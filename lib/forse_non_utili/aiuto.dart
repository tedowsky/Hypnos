import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/db.dart';
import '../utils/server_impact.dart';

Future<int> _authorize() async {

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

Future<int> _refreshTokens() async {
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

Future<List<HR>?> _requestData() async {

  final sp = await SharedPreferences.getInstance();
  final String? username = sp.getString('username');
  final String? codice = sp.getString('codice');

  if (username == Impact.username || codice == Impact.password){
    //Initialize the result
    List<HR>? result;

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await _refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final day = '2023-05-04';
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
        print('ciao');
    } //if
    else{
      result = null;
    }//else

    //Return the result
    return result;
    

  } //_requestData
}