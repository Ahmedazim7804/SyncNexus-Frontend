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

Future<dynamic> getUser(
    {required String userId,
      required String phoneNo,
      required String email,
      required String name,
      required String userType,
      required String firebaseUserId}) async {
  final Uri uri = Uri.parse('${getBaseURL()}/{user_id}/get-user/');
  Map<String, String> header = await headers();
  final response =
  await http.get(uri, headers: header);
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

// Future<bool> getUserLogs(
//     {required String phoneNo,
//       required String email,
//       required String name,
//       required String userType,
//       required String firebaseUserId}) async {
//   final Uri uri = Uri.parse('${getBaseURL()}/{user_id}/get-user-logs/');
//   final requestData = {
//     "phone_no": phoneNo,
//     "name": name,
//     "user_type": userType,
//     "firebase_user_id": firebaseUserId
//   };
//   if (email != "") {
//     requestData["email"] = email;
//   }
//   Map<String, String> header = await headers();
//   final response =
//   await http.get(uri, headers: header);
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     return true;
//   } else if (response.statusCode == 417 || response.statusCode == 409) {
//     return false;
//   } else {
//     throw Exception(
//         'Failed to load data from endpoint: ${response.statusCode} ${response.body}');
//   }
// }

Future<bool> addRating(
    {required String userTo,
      required String userFrom,
      required String rate,
      required String comment
    }) async {
  final Uri uri = Uri.parse('${getBaseURL()}/{user_id}/add-rating/');
  final requestData = {
    "user_from": userFrom,
    "user_to": userTo
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

Future<bool> getRating(
    {required String rate,
      required String count}) async {
  final Uri uri = Uri.parse('${getBaseURL()}/{user_id}/get-rating/');
  Map<String, String> header = await headers();
  final response =
  await http.get(uri, headers: header);
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

Future<bool> getPayments(
    {required String paymentId,
      required String amount,
      required String createdAt,
      required String fromUserID,
      required String toUserID,
      required String currency,
      required String remarks,
      required String approvedAt,
    }) async {
  final Uri uri = Uri.parse('${getBaseURL()}/user/get-payments/');
  final requestData = {
    "payment_id": paymentId,
    "amount": amount,
    "created_at": createdAt,
    "from_user_id": fromUserID,
    "to_user_id": toUserID,
    "currency": currency,
    "remarks": remarks,
    "approved_at": approvedAt
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

Future<bool> addFeedback(
    {required String fromUserID,
      required String rating,
      required String feedback
    }) async {
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
