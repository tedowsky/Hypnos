import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:hypnos/utils/server_impact.dart';
import 'package:hypnos/utils/shared_preferences.dart';

class ImpactService {
  ImpactService(this.prefs) {
    updateBearer();
  }

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
      Response response = await _dio.post('${ServerImpact.authServerUrl}token/',
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

  Future<List<dynamic>?> getbaseSleepData(DateTime startTime) async {
    await updateBearer();
    Response r_sleep = await _dio.get(
        '/data/v1/sleep/patients/Jpefaq6m58/day/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');

    if (r_sleep.data['data'] != null && r_sleep.data['data'].isNotEmpty) {
      List<dynamic> quasisleep = r_sleep.data['data']['data'];
      Map<String, dynamic> Listsleep = quasisleep[0];
      List<dynamic> firstNineElements = Listsleep.values.take(10).toList();
      return firstNineElements;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getsummarylevelsSleepData(
      DateTime startTime) async {
    await updateBearer();
    Response r_sleep = await _dio.get(
        '/data/v1/sleep/patients/Jpefaq6m58/day/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');

    print('ciao');
    if (r_sleep.data['data'] != null && r_sleep.data['data'].isNotEmpty) {
      Map<String, dynamic> respsleep = r_sleep.data['data'];
      List<dynamic> quasisleep = respsleep['data'];
      Map<String, dynamic> Listsleep = quasisleep[0];

      Map<String, dynamic> levelsummary = Listsleep['levels']['summary'];
      Map<String, dynamic> deep_summary = levelsummary['deep'];
      Map<String, dynamic> wake_summary = levelsummary['wake'];
      Map<String, dynamic> light_summary = levelsummary['light'];
      Map<String, dynamic> rem_summary = levelsummary['rem'];
      return {
        'deep_summary': deep_summary,
        'wake_summary': wake_summary,
        'light_summary': light_summary,
        'rem_summary': rem_summary,
      };
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> getlevelsSleepData(DateTime startTime) async {
    await updateBearer();
    Response r_sleep = await _dio.get(
        '/data/v1/sleep/patients/Jpefaq6m58/day/${DateFormat('y-M-d').format(DateTime.now().subtract(const Duration(days: 1)))}/');

    if (r_sleep.data['data'] != null && r_sleep.data['data'].isNotEmpty) {
      Map<String, dynamic> respsleep = r_sleep.data['data'];
      List<dynamic> quasisleep = respsleep['data'];
      Map<String, dynamic> Listsleep = quasisleep[0];

      List<dynamic> levels = Listsleep['levels']['data'];

      return levels;
    } else {
      return null;
    }
  }

  DateTime _truncateSeconds(DateTime input) {
    return DateTime(
        input.year, input.month, input.day, input.hour, input.minute);
  }
}
