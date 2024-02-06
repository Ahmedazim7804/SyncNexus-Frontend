import 'dart:convert';

import "package:http/http.dart" as http;

String getBaseURL() {
  return "http://0.0.0.0:80";
}

Map<String, String> headers() {
  String idToken =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY5NjI5NzU5NmJiNWQ4N2NjOTc2Y2E2YmY0Mzc3NGE3YWE5OTMxMjkiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWplZW0gQWhtYWQiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSkwyblNBQmo2U1NqWjVVRGcyOUhLVl9CSHExakR4X2NNa0M2U28wS3FhQU5NPXM5Ni1jIiwidXNlcl9pZCI6InZRMExOSXFCWkdmVFg2VHRveTZJTnJTaU5sYzIiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc29sdXRpb24tY2hhbGxlbmdlLWNhNTU0IiwiYXVkIjoic29sdXRpb24tY2hhbGxlbmdlLWNhNTU0IiwiYXV0aF90aW1lIjoxNzA3MjQ0NzQ4LCJzdWIiOiJ2UTBMTklxQlpHZlRYNlR0b3k2SU5yU2lObGMyIiwiaWF0IjoxNzA3MjQ0NzQ4LCJleHAiOjE3MDcyNDgzNDgsImVtYWlsIjoiYWhtZWRhemltNzgwNEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwNDk5ODQyMzAyMDcwMzYzMDY3MCJdLCJlbWFpbCI6WyJhaG1lZGF6aW03ODA0QGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6ImN1c3RvbSJ9fQ.HWIG7eBcJRmc2r4aQfEFSgE_L1PLp2HOYvX3l6RfRIvKGWbCXmXbk8kQsR0xqzdJUQiEYOEXKhbW4ul0y9RjFiwJdnKGnOl-opB4GlvETGNWhgfZvX9G-wrwxMyh1hAB8N5Go_VpB_NMYks1Nap39Zlk60sr7qkcQqTFUSzfbc7d1DTvaovoi6_PFW8uXyDX_MOE94stN1_YAb85fr_x6hSmgQOH2ER7XTM-ZeMJ-ngKFeb-rpcfxqqssDO_aS1dhz7OwofWfhFOOvkjB8d6nP9LI1mtnbKRF3ktUZ6IvTuaB1vrHRgqidRfygOH6eh7e_i_FNojsWUpnGe7cywVYw";
  return {
    "Authorization": "Bearer $idToken",
    'Content-Type': 'application/json'
  };
}

Future<bool> checkUser() async {
  final Uri uri = Uri.parse('${getBaseURL()}/user/check-user/');
  Map<String, String> header = headers();
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

Future<bool> createUser(
    String phoneNo, String name, String userType, String firebaseUserId) async {
  final Uri uri = Uri.parse('${getBaseURL()}/user/create-user/');
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
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<bool> addTask(String employeeID, String heading, String description,
    DateTime lastDate) async {
  lastDate = lastDate.toUtc();
  final Uri uri = Uri.parse('${getBaseURL()}/employer/add-task/');
  final requestData = {
    "employee_id": employeeID,
    "heading": heading,
    "description": description,
    "last_date": lastDate.toIso8601String()
  };
  Map<String, String> header = headers();
  final response =
      await http.post(uri, headers: header, body: jsonEncode(requestData));
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 401) {
    return false;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<bool> addEmployee(String employeeID) async {
  final Uri uri =
      Uri.parse('${getBaseURL()}/employer/$employeeID/add-employee/');
  Map<String, String> header = headers();
  final response = await http.get(uri, headers: header);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 406) {
    return false;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<List<dynamic>> getEmployees() async {
  final Uri uri = Uri.parse('${getBaseURL()}/employer/get-employees/');
  Map<String, String> header = headers();
  final response = await http.get(uri, headers: header);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}

Future<List<dynamic>> getLocation(
  String employeeID,
  DateTime startTime,
  DateTime endTime,
) async {
  final Uri uri =
      Uri.parse('${getBaseURL()}/employer/$employeeID/get-employee-location/');
  Map<String, String> header = headers();
  startTime = startTime.toUtc();
  endTime = endTime.toUtc();
  final requestData = {
    "start_time": startTime.toIso8601String(),
    "end_time": endTime.toIso8601String()
  };
  final response =
      await http.post(uri, headers: header, body: jsonEncode(requestData));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 404) {
    return [];
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
  }
}
