import 'dart:convert';

import "package:http/http.dart" as http;

String getBaseURL() {
  return "http://0.0.0.0:80";
}

Map<String, String> headers() {
  String idToken =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY5NjI5NzU5NmJiNWQ4N2NjOTc2Y2E2YmY0Mzc3NGE3YWE5OTMxMjkiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQVRJU0hBWSBKQUlOIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0xRcm5nQnVWQ0t1VmhfZ2JwY25VMXBvdExEWmFYVXVObXlQTTV6S0JfalB3PXM5Ni1jIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL3NvbHV0aW9uLWNoYWxsZW5nZS1jYTU1NCIsImF1ZCI6InNvbHV0aW9uLWNoYWxsZW5nZS1jYTU1NCIsImF1dGhfdGltZSI6MTcwNzE2MzY0OSwidXNlcl9pZCI6IllDRHVnb1hNd3dWZWFxczJTVk5EVzJZaGRoQTIiLCJzdWIiOiJZQ0R1Z29YTXd3VmVhcXMyU1ZORFcyWWhkaEEyIiwiaWF0IjoxNzA3MTYzNjQ5LCJleHAiOjE3MDcxNjcyNDksImVtYWlsIjoiYXRpc2hheWoyMjAyQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTA2Nzk4MDM2ODY1NzQ4MTAyNzI4Il0sImVtYWlsIjpbImF0aXNoYXlqMjIwMkBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJjdXN0b20ifX0.K3MxCVX7jwvU3EPTKwvAI3DLvIeUEwIokEb2qMsUUEmO0mLe96vZ5I_t71ODkpI5MAMOtt_hrhsTIUZeuzjoKSYewB0RFOGbBHvi5v7HsaaGishaEbyK7nH3No_B0HbzlX_tWrgMvw0zXib1AK_6bMImrQtjr5fTm6kgx065w8j6EUKjKLryhYCc--uLsJj_eSej4E_EpSZPzeg9w5SLBzNEcp3BEbkcnYnBjdUIHdtVPAiRgaqNvFt9xXdAp3HXlugFLfu01xAYD-55Z38pumQvvFi0dCTIg9R88UGwG2erhe9Y6nkzK9kmpMXahBq8-tJqsoKc0X1H8QNshzmp0g";
  return {"Authorization": "Bearer $idToken",'Content-Type': 'application/json'};
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
  Map<String, String> header = headers();
  final response =
      await http.post(uri, headers: header, body: jsonEncode(requestData));
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 417) {
    return false;
  }
  else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode}');
  }
}
