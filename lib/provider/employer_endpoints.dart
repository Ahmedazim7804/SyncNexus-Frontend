import 'dart:convert';
import "package:http/http.dart" as http;
import 'base_endpoints.dart';

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
  Map<String, String> header = await headers();
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

Future<bool> addEmployee(String employeeID, String title) async {
  final Uri uri =
  Uri.parse('${getBaseURL()}/employer/$employeeID/add-employee/$title');
  Map<String, String> header = await headers();
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
  Map<String, String> header = await headers();
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
  Map<String, String> header = await headers();
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

Future<dynamic> searchByPhone(String PhoneNo) async {
  final Uri uri =
  Uri.parse('${getBaseURL()}/employer/$PhoneNo/search-employee-phone/');
  Map<String, String> header = await headers();
  final response = await http.get(uri, headers: header);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return {};
  }
}