import 'dart:async';
import 'dart:convert';

import '../../_utils/logger.dart';
import '../../commands/files/pick_file_command.dart';
import '../firebase_config.dart';
import 'package:http/http.dart' as http;

class FirebaseRestApi {
  final FirebaseConfig _config = FirebaseConfig();
  // final AppUser user;

  static FirebaseRestApi? _instance;

  static FirebaseRestApi initialize() {
    if (initialized) {
      throw Exception('FirebaseAuthApi instance was already initialized');
    }
    _instance = FirebaseRestApi();
    return _instance!;
  }

  static bool get initialized => _instance != null;

  static FirebaseRestApi get instance {
    if (!initialized) {
      throw Exception(
          "FirebaseAuth hasn't been initialized. Please call FirebaseAuth.initialize() before using it.");
    }
    return _instance!;
  }

  late String _loginToken;
  late String _refreshToken;

  /// Stored the currently logged in user
  late String _currentUserId;
  late bool loggedIn = false;

  Future<void> logOut() async {}

  /// reauthenticate the existing user if the access token has expired
  /// with the refresh token
  /// it will return new access code;
  Future<String?> reauthenticate(String token) async {
    try {
      var response = await http.post(Uri.parse(_config.loginWithRefreshToken),
          // headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: json
              .encode({"grant_type": "refresh_token", "refresh_token": token}));

      if (response.statusCode == 200) {
        // TODO : REMOVE ALL OTHER VARIABLE
        ///getting the response body
        Map value = json.decode(response.body);
        //extracting the user from th body;
        log(value.toString());
        ////
        ///STORING REUSEABLE USER INFO IN THIS API
        ////
        _currentUserId = value["user_id"];
        // _ref = value["localId"];

        _loginToken = value["id_token"];
        // print(value);
        ////
        return _loginToken;
      }

      return null;
    } catch (err) {
      throw err;
    }
  }

  Future<Map?> signInWithToken(String token) async {
    try {
      var response = await http.post(Uri.parse(_config.loginWithAccessToken),
          body: json.encode({"idToken": token}));

      if (response.statusCode == 200) {
        // TODO : REMOVE ALL OTHER VARIABLE
        ///getting the response body
        Map value = json.decode(response.body);
        //extracting the user from th body;
        Map user = value["users"][0];
        ////
        ///STORING REUSEABLE USER INFO IN THIS API
        ////
        _currentUserId = user["localId"];
        _loginToken = token;
        // print(value);
        ////
        return value;
      }

      return null;
    } catch (err) {
      throw err;
    }
  }

  /// Made by default to access data from users
  /// in user collection as i commonly use it
  Future<Map<String, dynamic>?> getCurrentUserData() async {
    var userData = await getDoc("users/$_currentUserId");
    userData?["uid"] = _currentUserId;
    return userData;
  }

  /// [path] must include doc name if has any
  Future<bool> addDoc(Map<String, dynamic> doc, String path) async {
    try {
      var response = await http.post(Uri.parse("${_config.firestoreApi}/$path"),
          headers: {"Authorization": "Bearer $_loginToken"},
          body: json.encode({
            "fields": {
              // "title": {"stringValue": noteModel.title},
              // "description": {"stringValue": noteModel.description},
              // "colorValue": {"stringValue": noteModel.colorValue.toString()},
              //  "createdTime": {"stringValue":Utils.getServerTimeFormat(DateTime.now())}
            }
          }));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (err) {
      throw err;
    }
  }

  /// return a map of document from firestore
  Future<Map<String, dynamic>?> getDoc(String docID) async {
    try {
      var response = await http.get(Uri.parse("${_config.firestoreApi}/$docID"),
          headers: {"Authorization": "Bearer $_loginToken"});
      if (response.statusCode == 200) {
        //todo : Add an exception when the requested is null
        //todo : as non existing document
        Map map = json.decode(response.body)["fields"];
        // print(map);
        Map<String, dynamic> newMap = {};
        for (var key in map.keys.toList()) {
          var newValue = fireStoreParser(map[key]);
          print(newValue);
          newMap[key] = newValue;
        }
        print(newMap);

        return newMap;
      } else {
        Map map = json.decode(response.body);
        print(map);
        // throw (UserMessageException(map['error']['status']));
        return null;
      }
    } catch (err) {
      print('getNotes catch $err');
      throw (err);
    }
  }

  ///////////////////////////////////////
  ///firestore doc parser
  //////////////////////////////////////
  String? getFireStoreProp(Map<String, dynamic> value) {
    final props = {
      'arrayValue': 1,
      'bytesValue': 1,
      'booleanValue': 1,
      'doubleValue': 1,
      'geoPointValue': 1,
      'integerValue': 1,
      'mapValue': 1,
      'nullValue': 1,
      'referenceValue': 1,
      'stringValue': 1,
      'timestampValue': 1
    };

    return value.keys
        .firstWhere((k) => props[k] == 1, orElse: () => "mapValue");
  }

  dynamic fireStoreParser(dynamic value) {
    final prop = getFireStoreProp(value);

    if (prop == 'doubleValue' || prop == 'integerValue') {
      value = num.parse(value[prop]);
    } else if (prop == 'arrayValue') {
      value = (value[prop] != null
          ? (value[prop]['values'] as List<dynamic>?)
              ?.map((v) => fireStoreParser(v))
              .toList()
          : []);
    } else if (prop == 'mapValue') {
      value = fireStoreParser(value[prop] != null ? value[prop]['fields'] : {});
    } else if (prop == 'geoPointValue') {
      final geoPointValue = value[prop] ?? {};
      value = <String, dynamic>{
        'latitude': 0,
        'longitude': 0,
        ...geoPointValue,
      };
    } else if (prop != null) {
      value = value[prop];
    } else if (value is Map<String, dynamic>) {
      for (var k in value.keys) {
        value[k] = fireStoreParser(value[k]);
      }
    }
    return value;
  }

  ///////////////////////////////////////
  ///firebase STORAGE
  //////////////////////////////////////

  Future<Map?> uploadFile(PickedFile file) async {
    String? file2upload = file.path;
    String bucket = _config.storageBucket;
    String storagePath = '$_currentUserId/uploads/${file.name}';
    // .replaceAll('/', '%2F');
    String url2file =
        'https://firebasestorage.googleapis.com/v0/b/$bucket/o/$storagePath';

    try {
      var response = await http.post(Uri.parse(url2file),
          // headers: {"Content-Type": "image/png","Authorization": "Bearer $_loginToken"},
          headers: {"Authorization": "Bearer $_loginToken"},
          body: json.encode({"data": file2upload}));

      if (response.statusCode == 200) {
        // TODO : REMOVE ALL OTHER VARIABLE
        ///getting the response body
        Map value = json.decode(response.body);
        print(value);
        ////
        return value;
      }

      return null;
    } catch (err) {
      print(err);
      return null;
    }
  }
}
