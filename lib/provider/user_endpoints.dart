import 'dart:convert';
import "package:http/http.dart" as http;

String getBaseURL() {
  return "http://0.0.0.0:80";
}

Map<String, String> headers() {
  String idToken =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY5NjI5NzU5NmJiNWQ4N2NjOTc2Y2E2YmY0Mzc3NGE3YWE5OTMxMjkiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWplZW0gQWhtYWQiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSkwyblNBQmo2U1NqWjVVRGcyOUhLVl9CSHExakR4X2NNa0M2U28wS3FhQU5NPXM5Ni1jIiwidXNlcl9pZCI6InZRMExOSXFCWkdmVFg2VHRveTZJTnJTaU5sYzIiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc29sdXRpb24tY2hhbGxlbmdlLWNhNTU0IiwiYXVkIjoic29sdXRpb24tY2hhbGxlbmdlLWNhNTU0IiwiYXV0aF90aW1lIjoxNzA3MjM3MTUwLCJzdWIiOiJ2UTBMTklxQlpHZlRYNlR0b3k2SU5yU2lObGMyIiwiaWF0IjoxNzA3MjM3MTUwLCJleHAiOjE3MDcyNDA3NTAsImVtYWlsIjoiYWhtZWRhemltNzgwNEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwNDk5ODQyMzAyMDcwMzYzMDY3MCJdLCJlbWFpbCI6WyJhaG1lZGF6aW03ODA0QGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6ImN1c3RvbSJ9fQ.alTd7ATH8Y0C5ERoMmbuc91iosSMxB_eJ9AcxCzIi3CrcVS_ipTT4VX1wfT72adk_TGYLABWHziVHsJxONLAhVTbYPK1gHdB4gOPfL1-kmEU8kcjSWv5l-tfBsgr2Vme-hIkzXe4m39ACqU6KyQYMDndIS0wC70oGYCB4yTeacCPOsSS8rS90B7tF5COI9J2M6Ni4pg78zkcafygeTlf5AICoXaUmA--OWQFcM789GRo21JnlsbqunTpqGTUApt3Qim51oQyfL8jrA5HwWGK-rLtNeyJFCrORQ7x8VxjbNkcJ7osWmewnWKZ0RO9GOhfZDsYA9k4NsR6fg4PiDDT4A";
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
  print(jsonEncode(requestData));
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

Future<bool> addTask(
    String employeeID, String heading, String description, DateTime lastDate) async {
  final Uri uri = Uri.parse(
      '${getBaseURL()}/employer/add-task/');
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
        'Failed to load data from endpoint: ${response.statusCode}');
  }
}