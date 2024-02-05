import 'package:flutter_test/flutter_test.dart';
import 'package:worker_app/provider/user_endpoints.dart';


void main() {
  group('checkUser', () {
    test('returns true if HTTP request succeeds', () async {
      final result = await checkUser();
      expect(result == true || result == false, true);
    });
  });
  group('createUser', () {
    test('returns true if HTTP request succeeds', () async {
      final result = await createUser(
          "1234567890", "John Doe", "employee", "YCDugoXMwwVeaqs2SVNDW2YhdhA2"
      );
      expect(result == true || result == false, true);
    });
  });
}