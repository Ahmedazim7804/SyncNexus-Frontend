import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:worker_app/ui/screens/authentication/otp_screen.dart';
import 'package:worker_app/ui/screens/authentication/signup_screen.dart';
import 'package:worker_app/ui/screens/authentication/worker_screen/worker_home.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class MyAppRouter {
  static GoRouter goRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/screens/worker/homescreen',
      routes: [
        GoRoute(
          path: '/screens/authentication/signup',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SignUpScreen()),
        ),
        GoRoute(
          path: '/screens/authentication/otp',
          pageBuilder: (context, state) =>
              const MaterialPage(child: OtpScreen()),
        ),
        GoRoute(
          path: '/screens/worker/homescreen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: WorkerHomeScreen()),
        ),
      ]);
}
