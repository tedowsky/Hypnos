import 'dart:convert';
import 'dart:io';

import 'package:hypnos/services/server_strings.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:intl/intl.dart';
import 'package:hypnos/utils/server_impact.dart';
import 'package:hypnos/utils/shared_preferences.dart';
import 'package:hypnos/models/db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ImpactService {
  ImpactService(this.prefs);

  Preferences prefs;


  String? retrieveSavedToken(bool refresh) {
    if (refresh) {
      return prefs.impactRefreshToken;
    } else {
      return prefs.impactAccessToken;
    }
  }

  bool checkSavedToken({bool refresh = false}) {
    String? token = retrieveSavedToken(refresh);
    //Check if there is a token
    if (token == null) {
      return false;
    }
    try {
      return ImpactService.checkToken(token);
    } catch (_) {
      return false;
    }
  }

  // this method is static because we might want to check the token outside the class itself
  static bool checkToken(String token) {
    //Check if the token is expired
    if (JwtDecoder.isExpired(token)) {
      return false;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    //Check the iss claim
    if (decodedToken['iss'] == null) {
      return false;
    } else {
      if (decodedToken['iss'] != ServerStrings.issClaim) {
        return false;
      } //else
    } //if-else

    //Check that the user is a patient
    if (decodedToken['role'] == null) {
      return false;
    } else {
      if (decodedToken['role'] != ServerStrings.researcherRoleIdentifier) {
        return false;
      } //else
    } //if-else

    return true;
  } //checkToken




Future<int> authorize() async {
  final sp = await SharedPreferences.getInstance();
  final String? username = sp.getString('username');
  final String? codice = sp.getString('codice');

  if (username == Impact.username || codice == Impact.password){
  //Create the request
  final url = Impact.baseUrl + Impact.tokenEndpoint;
  final body = {'username': Impact.username, 'password': Impact.password};

  //Get the response
  print('Calling: $url');
  final response = await http.post(Uri.parse(url), body: body);

  
  //If response is OK, decode it and store the tokens. Otherwise do nothing.
  if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body);
    final sp = await SharedPreferences.getInstance();
    await sp.setString('access', decodedResponse['access']);
    await sp.setString('refresh', decodedResponse['refresh']);
  } //if

  //Just return the status code
  return response.statusCode;} 
  else{
    return 400;
  }
} //_getAndStoreTokens




  // make the call to get the tokens
  // Future<bool> getTokens(String username, String password) async {
  //   try {
  //     Response response = await _dio.post(
  //         '${ServerStrings.authServerUrl}token/',
  //         data: {'username': username, 'password': password},
  //         options: Options(
  //             contentType: 'application/json',
  //             followRedirects: false,
  //             validateStatus: (status) => true,
  //             headers: {"Accept": "application/json"}));

  //     if (ImpactService.checkToken(response.data['access']) &&
  //         ImpactService.checkToken(response.data['refresh'])) {
  //       prefs.impactRefreshToken = response.data['refresh'];
  //       prefs.impactAccessToken = response.data['access'];
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<int> refreshTokens() async {
  //Create the request
  final url = Impact.baseUrl + Impact.refreshEndpoint;
  final sp = await SharedPreferences.getInstance();
  final refresh = sp.getString('refresh');
  final body = {'refresh': refresh};

  //Get the respone
  print('Calling: $url');
  final response = await http.post(Uri.parse(url), body: body);

  //If 200 set the tokens
  if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body);
    final sp = await SharedPreferences.getInstance();
    sp.setString('access', decodedResponse['access']);
    sp.setString('refresh', decodedResponse['refresh']);
  } //if

  //Return just the status code
  return response.statusCode;
} //_refreshTokens




Future<List<HR>?> requestData() async {

  final sp = await SharedPreferences.getInstance();
  final String? username = sp.getString('username');
  final String? password= sp.getString('password');
  

  if (username == Impact.username || password == Impact.password){
    //Initialize the result
    List<HR>? result;

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    const day = '2023-05-04';
    final url = Impact.baseUrl + Impact.heartrateEndpoint + Impact.patientUsername + '/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    
    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];      
        for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
          result.add(HR.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data'][i]));
        }//for
    } //if
    else{
      result = null;
    }//else

    //Return the result
    return result;
    

  } //_requestData
}

//   Future<bool> refreshTokens() async {
//     String? refToken = await retrieveSavedToken(true);
//     try {
//       Response response = await _dio.post(
//           '${ServerStrings.authServerUrl}refresh/',
//           data: {'refresh': refToken},
//           options: Options(
//               contentType: 'application/json',
//               followRedirects: false,
//               validateStatus: (status) => true,
//               headers: {"Accept": "application/json"}));

//       if (ImpactService.checkToken(response.data['access']) &&
//           ImpactService.checkToken(response.data['refresh'])) {
//         prefs.impactRefreshToken = response.data['refresh'];
//         prefs.impactAccessToken = response.data['access'];
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   Future<void> updateBearer() async {
//     if (!await checkSavedToken()) {
//       await refreshTokens();
//     }
//     String? token = await prefs.impactAccessToken;
//     if (token != null) {
//       _dio.options.headers = {'Authorization': 'Bearer $token'};
//     }
//   }

//   Future<void> getPatient() async {
//     await updateBearer();
//     Response r = await _dio.get('study/v1/patients/active');
//     prefs.impactUsername = r.data['data'][0]['username'];
//     return r.data['data'][0]['username'];
//   }

//   Future<List<HR>> getDataFromDay(DateTime startTime) async {
//     await updateBearer();
//     Response r = await _dio.get(
//         'data/v1/heart_rate/patients/${prefs.impactUsername}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
//     List<dynamic> data = r.data['data'];
//     List<HR> hr = [];
//     for (var daydata in data) {
//       String day = daydata['date'];
//       for (var dataday in daydata['data']) {
//         String hour = dataday['time'];
//         String datetime = '${day}T$hour';
//         DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
//         HR hrnew = HR(timestamp: timestamp, value: dataday['value']);
//         if (!hr.any((e) => e.timestamp.isAtSameMomentAs(hrnew.timestamp))) {
//           hr.add(hrnew);
//         }
//       }
//     }
//     var hrlist = hr.toList()
//       ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
//     return hrlist;
//   }

//   DateTime _truncateSeconds(DateTime input) {
//     return DateTime(
//         input.year, input.month, input.day, input.hour, input.minute);
//   }


// }


}