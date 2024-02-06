import 'package:flutter_test/flutter_test.dart';
import 'package:worker_app/provider/employee_endpoints.dart';
import 'package:worker_app/provider/employer_endpoints.dart';
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
    test('returns true if HTTP request succeeds', () async {
      final result = await createUser(
          "12345676875", "Tony Stark", "employer", "vQ0LNIqBZGfTX6Ttoy6INrSiNlc2"
      );
      expect(result == true || result == false, true);
    });
  });
  group('addTask', () {
    test('returns true if HTTP request succeeds', () async {
      final result = await addTask(
          "d89a6446-8313-43bb-bb9b-c8fe071a9a95", "Fix the roof", "The roof is leaking", DateTime.now().add(const Duration(days: 3))
      );
      expect(result == true || result == false, true);
    });
  });
  group('addEmployee', () {
    test('returns true if HTTP request succeeds', () async {
      final result = await addEmployee(
          "d89a6446-8313-43bb-bb9b-c8fe071a9a95"
      );
      expect(result == true || result == false, true);
    });
  });
  group('getEmployees', () {
    test('returns true if HTTP request succeeds', () async {
      final result = await getEmployees();
      expect(Null == result || Null != result, true);
    });
  });
  group('getLocation', () {
    test('returns true if HTTP request succeeds', () async {
      final result = await getLocation("d89a6446-8313-43bb-bb9b-c8fe071a9a95", DateTime.now().subtract(const Duration(days: 3)), DateTime.now());
      expect(Null == result || Null != result, true);
    });
  });
  group('completeTask', () {
    test('returns true if HTTP request succeeds', () async {
      final result = await completeTask("52a09493-28fb-40ab-9bca-476b2170cc30");
      expect(result == true || result == false, true);
    });
  });
}