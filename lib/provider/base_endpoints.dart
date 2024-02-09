import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

String getBaseURL() {
  return "https://google-solution-challenge-backend-jpnacpp5ta-em.a.run.app";
  //return "http://0.0.0.0:80";
}

Future<Map<String, String>> headers() async {
  //late final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //String? idToken = await firebaseAuth.currentUser!.getIdToken();
  String idToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjUzZWFiMDBhNzc5MTk3Yzc0MWQ2NjJmY2EzODE1OGJkN2JlNGEyY2MiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWplZW0gQWhtYWQiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSkwyblNBQmo2U1NqWjVVRGcyOUhLVl9CSHExakR4X2NNa0M2U28wS3FhQU5NPXM5Ni1jIiwidXNlcl9pZCI6InZRMExOSXFCWkdmVFg2VHRveTZJTnJTaU5sYzIiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc29sdXRpb24tY2hhbGxlbmdlLWNhNTU0IiwiYXVkIjoic29sdXRpb24tY2hhbGxlbmdlLWNhNTU0IiwiYXV0aF90aW1lIjoxNzA3NDYyNDIwLCJzdWIiOiJ2UTBMTklxQlpHZlRYNlR0b3k2SU5yU2lObGMyIiwiaWF0IjoxNzA3NDYyNDIwLCJleHAiOjE3MDc0NjYwMjAsImVtYWlsIjoiYWhtZWRhemltNzgwNEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwNDk5ODQyMzAyMDcwMzYzMDY3MCJdLCJlbWFpbCI6WyJhaG1lZGF6aW03ODA0QGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6ImN1c3RvbSJ9fQ.nJ_RNKRU7xPWr3mR8dH6fmg8MCJQ9rIX_5lK_DXYkbHqlIpZbM4ozxIo3vp8iJRvE8W0SOjPLHkkJ7cFe6J1t9XgMZYa9DNaqh7aL_LCQSfeec0uBE9X97tzfeNZ1NqhBlUktWFRvSLHyzqcZ-GWcn79GiNtncTQRurCO9Kx5xUXadGaKvBnX3VnLMdD9whHWuUvXNGHalHtnZwaA9mYO9qBvCjSzajJJvxi-y2ZNZmCoMTBgfNKXokQCZWTSmP6E0ty8niHg1A67dQa_wp0T8PRa9tM7bMcAiU4jRQrtv98_ErLt5P1OkuCuNuE--sktzJxCv3-aLEnWqxKMw742A";
  return {
    "Authorization": "Bearer $idToken",
    'Content-Type': 'application/json'
  };
}
