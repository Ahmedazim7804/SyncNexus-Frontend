import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

String getBaseURL() {
  return "https://google-solution-challenge-backend-jpnacpp5ta-em.a.run.app";
}

Future<Map<String, String>> headers() async {
  late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? idToken = await firebaseAuth.currentUser!.getIdToken();
  return {
    "Authorization": "Bearer $idToken",
    'Content-Type': 'application/json'
  };
}
