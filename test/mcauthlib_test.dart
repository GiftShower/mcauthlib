import 'package:mcauthlib/mcauthlib.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final auth = MojangAuth();
    var user = User.authType("syrad99@naver.com", "florida6828");

    setUp(() {
      // Additional setup goes here.
    });

    test('Authenticate Test', () async {
      var result = await auth.authenticate(user);
      expect(result['responseType'], ResponseType.success);
    });
  });
}
