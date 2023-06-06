import 'dart:convert';

import 'package:hypnos/databases/entities/entities.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:hypnos/utils/server_impact.dart';
import 'package:hypnos/utils/shared_preferences.dart';

class ImpactService {
  ImpactService(this.prefs) {
    updateBearer();

    
  }

  final day = DateTime.now();
  Preferences prefs;

  final Dio _dio = Dio(BaseOptions(baseUrl: ServerImpact.backendBaseUrl));

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
      if (decodedToken['iss'] != ServerImpact.issClaim) {
        return false;
      } //else
    } //if-else

    //Check that the user is a patient
    if (decodedToken['role'] == null) {
      return false;
    } else {
      if (decodedToken['role'] != ServerImpact.researcherRoleIdentifier) {
        return false;
      } //else
    } //if-else

    return true;
  } //checkToken

  // make the call to get the tokens
  Future<bool> getTokens(String username, String password) async {
    try {
      Response response = await _dio.post(
          '${ServerImpact.authServerUrl}token/',
          data: {'username': username, 'password': password},
          options: Options(
              contentType: 'application/json',
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Accept": "application/json"}));

      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['access'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> refreshTokens() async {
    String? refToken = await retrieveSavedToken(true);
    try {
      Response response = await _dio.post(
          '${ServerImpact.authServerUrl}refresh/',
          data: {'refresh': refToken},
          options: Options(
              contentType: 'application/json',
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {"Accept": "application/json"}));

      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['access'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateBearer() async {
    if (!await checkSavedToken()) {
      await refreshTokens();
    }
    String? token = await prefs.impactAccessToken;
    if (token != null) {
      _dio.options.headers = {'Authorization': 'Bearer $token'};
    }
  }

  Future<void> getPatient() async {
    await updateBearer();
    Response r = await _dio.get('study/v1/patients/active');
    prefs.impactUsername = r.data['data'][0]['username'];
    return r.data['data'][0]['username'];
  }

  Future<List<HR>> getDataFromDay(DateTime startTime) async {
    await updateBearer();
    Response r = await _dio.get(
      '/data/v1/heart_rate/patients/Jpefaq6m58/day/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
      // 'data/v1/heart_rate/patients/${prefs.impactUsername}/daterange/start_date/${DateFormat('y-M-d').format(startTime)}/end_date/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');
    Map<String, dynamic> responseData = r.data['data'];
    List<dynamic> dataList = responseData['data'];

    List<HR> hr = [];
    for (var daydata in dataList) {
      String day = responseData['date'];
      for (var dataday in responseData['data']) {
        String hour = dataday['time'];
        String datetime = '${day}T$hour';
        DateTime timestamp = _truncateSeconds(DateTime.parse(datetime));
        HR hrnew = HR(null, dataday['value'], timestamp);
        if (!hr.any((e) => e.dateTime.isAtSameMomentAs(hrnew.dateTime))) {
          hr.add(hrnew);
        }
      }
    }
    var hrlist = hr.toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));
     return hrlist;
  }

  DateTime _truncateSeconds(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }
}