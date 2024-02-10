import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

String getBaseURL() {
  return "https://google-solution-challenge-backend-jpnacpp5ta-em.a.run.app";
  //return "http://0.0.0.0:80";
  //return "https://test-google-solution-challenge-backend-jpnacpp5ta-em.a.run.app";
}

Future<Map<String, String>> headers() async {
  //late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //String? idToken = await firebaseAuth.currentUser!.getIdToken();
  String idToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjUzZWFiMDBhNzc5MTk3Yzc0MWQ2NjJmY2EzODE1OGJkN2JlNGEyY2MiLCJ0eXAiOiJKV1QifQ.eyJ1c2VyX2lkIjoidlEwTE5JcUJaR2ZUWDZUdG95NklOclNpTmxjMiIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9zb2x1dGlvbi1jaGFsbGVuZ2UtY2E1NTQiLCJhdWQiOiJzb2x1dGlvbi1jaGFsbGVuZ2UtY2E1NTQiLCJhdXRoX3RpbWUiOjE3MDc1MDQyNjcsInN1YiI6InZRMExOSXFCWkdmVFg2VHRveTZJTnJTaU5sYzIiLCJpYXQiOjE3MDc1MDQyNjcsImV4cCI6MTcwNzUwNzg2NywiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6e30sInNpZ25faW5fcHJvdmlkZXIiOiJjdXN0b20ifX0.X7LcOWIkKaLNZzRuKPS28bpV43kEWUDaG9wFSQ6Nf_mH54PaBdRK2ltcJJpDON_5UNwHnATjiOBivgY9ZrAKS4CLsPfPSrTuPnB4u93srhHFJvVagGT-9Uz7bdt7eF1MoS9DfcH7onlUg5kEeTlk0poiwjZL1kRzzJw5O5h80xJbqrKsKXMWwxSElDM0gTkMgFVWNKGn76e__hn_xE0QXmJUxJo14k7rdhP53YOPLg8DSLz55ivYORwEbdPRBiA5X_g9vetwu4W2Ewx6uiEG-kFfkGRE3Dz1aMB2x7C4-e4nXItigckYLX7h-8q5yD4mrF1gslVht30Gdm6kf7NwDA";
  return {
    "Authorization": "Bearer $idToken",
    'Content-Type': 'application/json'
  };
}
