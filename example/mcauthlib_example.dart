import 'package:mcauthlib/mcauthlib.dart';

void main() async {
  //This example is how to authenticate, refresh, validate and sign out.

  //First create MojangAuth instance.
  final auth = MojangAuth();
  //Then, create User with authtype keyword.
  //The first parameter is email and the second one is password.
  var user = User.authType("lorem@ipsum.com", "dolorsitamet");

  //await until authentication return map with
  //Response type, clientToken, accessToken, player uuid.
  var result = await auth.authenticate(user);

  //If a request was successful the response type should be
  //ResponseType.success
  //if not, it will return ResponseType.failure with error Type.
  if(result['responseType'] == ResponseType.success){
    user.clientToken = result['clientToken'];
    user.accessToken = result['accessToken'];
  }
  //TODO: More.
}
