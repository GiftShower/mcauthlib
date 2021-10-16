import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mcauthlib/src/mcalenums.dart';

import 'mojangtypes.dart';

///Yggdrasil Authentication
class MojangAuth {
  String baseURL = "https://authserver.mojang.com";
  Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
  };

  ///Authenticate with email and password. User should be created with User.authtype()
  Future<Map<String, dynamic>> authenticate(User target) async {
    var url = Uri.parse(baseURL + "/authenticate");
    Auth payload = Auth(target.username,target.password);
    var response = await http.post(url, headers: headers,body: jsonEncode(payload));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    if(decodedResponse.containsKey("error")){
      return Map.from({
        'responeType': ResponseType.failure,
        'errorType': decodedResponse['error']
      });
    } else {
      return Map.from({
        'responseType': ResponseType.success,
        'clientToken': decodedResponse['clientToken'],
        'accessToken': decodedResponse['accessToken'],
        'uuid': decodedResponse['selectedProfile']['id']
      });
    }
  }

  ///Refresh authentication. User should be created with User.refreshtype()
  Future<Map<String, dynamic>> refresh(User target) async {
    var url = Uri.parse(baseURL + '/refresh');
    Map<String, String> payload = {
      'accessToken': target.accessToken,
      'clientToken': target.clientToken
    };
    var response = await http.post(url,headers: headers, body: jsonEncode(payload));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    if(decodedResponse.containsKey("error")){
      return Map.from({
        'responeType': ResponseType.failure,
        'errorType': decodedResponse['error']
      });
    } else {
      return Map.from({
        'responseType': ResponseType.success,
        'accessToken': decodedResponse['accessToken']
      });
    }
  }

  ///Validate clientToken. User should be created with User.refreshtype()
  Future<ResponseType> validate(User target) async {
    var url = Uri.parse(baseURL + '/refresh');
    Map<String, String> payload = {
      'accessToken': target.accessToken,
      'clientToken': target.clientToken
    };
    var response = await http.post(url, headers: headers,body: jsonEncode(payload));

    if(response.statusCode == 204) {
      return ResponseType.success;
    } else {
      return ResponseType.failure;
    }
  }

  ///Invalidates accessTokens using an account's username and password.
  ///User should be created with User.authType()
  Future<ResponseType> signOut(User target) async {
    var url = Uri.parse(baseURL + '/signout');
    Map<String, String> payload = {
      'username': target.username,
      'password': target.password
    };
    var response = await http.post(url, headers: headers,body: jsonEncode(payload));
    if(response.statusCode == 204) {
      return ResponseType.success;
    } else {
      return ResponseType.failure;
    }
  }

  ///Invalidates accessTokens using a client/access token pair.
  ///clientToken needs to be identical to the one used to obtain the accessToken in the first place
  Future<ResponseType> invalidate(String accessToken, String clientToken) async {
    var url = Uri.parse(baseURL + '/invalidate');
    Map<String, String> payload = {
      'accessToken': accessToken,
      'clientToken': clientToken
    };
    var response = await http.post(url, headers: headers,body: jsonEncode(payload));
    if(response.statusCode == 204) {
      return ResponseType.success;
    } else {
      return ResponseType.failure;
    }
  }
}
