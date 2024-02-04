import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthListen extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final StreamSubscription<dynamic> subscription;
  User? user;
  bool isSignedIn = false;

  AuthListen() {
    notifyListeners();
    subscription = firebaseAuth.authStateChanges().listen((event) {
      user = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }
}
