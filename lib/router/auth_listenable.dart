import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker_app/provider/user_endpoints.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  needToFinishSignup,
  waiting,
}

class AuthListen extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final StreamSubscription<dynamic> subscription;
  User? userx;

  AuthenticationStatus status = AuthenticationStatus.waiting;
  late bool isEmployee;

  AuthListen() {
    notifyListeners();
    listenToFirebaseAuth();
  }

  void listenToFirebaseAuth() async {
    subscription = firebaseAuth.authStateChanges().listen((user) async {
      if (user != null) {
        print('1');
        bool existOnBackend = await checkUser();
        print('2');

        if (existOnBackend) {
          final backendUser = await getUser();
          print('3');
          isEmployee = backendUser['user_type'] == 'employee' ? true : false;

          status = AuthenticationStatus.authenticated;
        } else {
          status = AuthenticationStatus.needToFinishSignup;
        }
      } else {
        print('4');
        status = AuthenticationStatus.unauthenticated;
      }

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
