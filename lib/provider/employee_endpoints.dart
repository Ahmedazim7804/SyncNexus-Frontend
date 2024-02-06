import 'base_endpoints.dart';
import "package:http/http.dart" as http;

Future<bool> completeTask(String taskID) async {
  final Uri uri =
  Uri.parse('${getBaseURL()}/employee/$taskID/complete-task/');
  Map<String, String> header = headers();
  final response = await http.get(uri, headers: header);
  if (response.statusCode == 200) {
    return true;
  } else if (response.statusCode == 409 || response.statusCode == 404) {
    return false;
  } else {
    throw Exception(
        'Failed to load data from endpoint: ${response.statusCode} ${response.body}'
    );
  }
}