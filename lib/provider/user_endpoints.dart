import 'dart:convert';

import "package:http/http.dart" as http;

String getBaseURL() {
  return "http://0.0.0.0:80";
}

Map<String, String> headers() {
  String idToken =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY5NjI5NzU5NmJiNWQ4N2NjOTc2Y2E2YmY0Mzc3NGE3YWE5OTMxMjkiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQVRJU0hBWSBKQUlOIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0xRcm5nQnVWQ0t1VmhfZ2JwY25VMXBvdExEWmFYVXVObXlQTTV6S0JfalB3PXM5Ni1jIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3NvbHV0aW9uLWNoYWxsZW5nZS1jYTU1NCIsImF1ZCI6InNvbHV0aW9uLWNoYWxsZW5nZS1jYTU1NCIsImF1dGhfdGltZSI6MTcwNzE1OTUxMCwidXNlcl9pZCI6IllDRHVnb1hNd3dWZWFxczJTVk5EVzJZaGRoQTIiLCJzdWIiOiJZQ0R1Z29YTXd3VmVhcXMyU1ZORFcyWWhkaEEyIiwiaWF0IjoxNzA3MTU5NTEwLCJleHAiOjE3MDcxNjMxMTAsImVtYWlsIjoiYXRpc2hheWoyMjAyQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTA2Nzk4MDM2ODY1NzQ4MTAyNzI4Il0sImVtYWlsIjpbImF0aXNoYXlqMjIwMkBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJjdXN0b20ifX0.EPreyjQjqsjukYnf_fO4FsuoO4IsSQn5lnH6Ws0IsHN8rheRs4hgUr6e4Rpf5JOXQEEOu2fF2HgEy50_KQuyQWDwUgT5fS8EqZrwWDjWrAIosCzrVNkqAR-hTCHmVeHJ8pqVVCdDZ8P5pRfHHy9FKQvEL0XktRGJi4K_rjbO_rVAjvKFqGO0P5tCVs6PipyUKypVzGeUhuNg8vharemD_pWF0ti0NLoKX1d7pB4Q_J-8yBurWnqcG0LiICty2JBPbq8slauo7hMbzyDkwZzx-Vrk12KSYxBozdwglObLsApi92-Q4-zx9TqDNMBrJcBR4QSovdRZeOx-XGyDHCVqGA";
  return {"Authorization": "Bearer $idToken"};
}

Future<bool> checkUser() async {
  final Uri uri = Uri.parse(
      '${getBaseURL()}/user/check-user/');
  Map<String, String> header = headers();
  final response = await http.get(uri, headers: header);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode}');
  }
}

Future<bool> createUser(
    String phoneNo, String name, String userType, String firebaseUserId) async {
  final Uri uri = Uri.parse(
      '${getBaseURL()}/user/create-user/');
  final requestData = {
    "phone_no": phoneNo,
    "name": name,
    "user_type": userType,
    "firebase_user_id": firebaseUserId
  };
  final response =
      await http.post(uri, body: jsonEncode(requestData));
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode}');
  }
}
