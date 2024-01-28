import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:worker_app/screens/otp_screen.dart';
import 'package:worker_app/screens/signup_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class MyAppRouter {
  static GoRouter goRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/screens/signup/signup',
      routes: [
        GoRoute(
          path: '/screens/signup/signup',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SignUpScreen()),
        ),
        GoRoute(
          path: '/screens/signup/otp',
          pageBuilder: (context, state) =>
              const MaterialPage(child: OtpScreen()),
        )
      ]);
}
