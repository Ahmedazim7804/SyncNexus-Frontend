import 'dart:convert';

import "package:http/http.dart" as http;

import 'base_endpoints.dart';

Future<bool> checkUser() async {
  final Uri uri = Uri.parse('${getBaseURL()}/user/check-user/');
  Map<String, String> header = await headers();
  final response = await http.get(uri, headers: header);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<bool> createUserOnBackend(
    {required String phoneNo,
    required String email,
    required String name,
    required String userType,
    required String firebaseUserId}) async {
  final Uri uri = Uri.parse('${getBaseURL()}/user/create-user/');
  final requestData = {
    "phone_no": phoneNo,
    "name": name,
    "user_type": userType,
    "firebase_user_id": firebaseUserId
  };
  if (email != "") {
    requestData["email"] = email;
  }
  Map<String, String> header = await headers();
  final response =
      await http.post(uri, headers: header, body: jsonEncode(requestData));
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 417 || response.statusCode == 409) {
    return false;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}
