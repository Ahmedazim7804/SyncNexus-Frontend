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
  Map<String, String> header = await headers();
  final response =
      await http.post(uri, headers: header, body: jsonEncode(requestData));
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 417 || response.statusCode == 409) {
    return false;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<dynamic> getUser(// under testing
    ) async {
  final Uri uri = Uri.parse('${getBaseURL()}/get-user/');
  Map<String, String> header = await headers();
  final response = await http.get(uri, headers: header);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<bool> addRating(String userTo, String rate, String comment) async {// under testing
  final Uri uri = Uri.parse('${getBaseURL()}/$userTo/add-rating/');
  final requestData = {"rate": rate, "comment": comment};
  Map<String, String> header = await headers();
  final response =
      await http.post(uri, headers: header, body: jsonEncode(requestData));
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<bool> getRating(String userTo) async {// under testing
  final Uri uri = Uri.parse('${getBaseURL()}/$userTo/get-rating/');
  Map<String, String> header = await headers();
  final response = await http.get(uri, headers: header);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<bool> getPayments(DateTime startTime, DateTime endTime) async {// under testing
  startTime = startTime.toUtc();
  endTime = endTime.toUtc();
  final requestData = {
    "start_time": startTime.toIso8601String(),
    "end_time": endTime.toIso8601String()
  };
  final Uri uri = Uri.parse('${getBaseURL()}/user/get-payments/');
  Map<String, String> header = await headers();
  final response =
      await http.post(uri, headers: header, body: jsonEncode(requestData));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<bool> addFeedback(// under testing
    {required String fromUserID,
    required String rating,
    required String feedback}) async {
  final Uri uri = Uri.parse('${getBaseURL()}/user/add-feedback/');
  final requestData = {
    "from_user_id": fromUserID,
    "rating": rating,
    "feedback": feedback
  };
  Map<String, String> header = await headers();
  final response =
      await http.post(uri, headers: header, body: jsonEncode(requestData));
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 417 || response.statusCode == 409) {
    return false;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}
