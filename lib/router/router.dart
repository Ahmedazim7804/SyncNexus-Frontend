import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:worker_app/router/auth_listenable.dart';
import 'package:worker_app/ui/screens/authentication/otp_screen.dart';
import 'package:worker_app/ui/screens/authentication/signup_screen.dart';
import 'package:worker_app/ui/screens/authentication/steps/signup_step_1.dart';
import 'package:worker_app/ui/screens/authentication/steps/signup_step_2.dart';
import 'package:worker_app/ui/screens/worker_screen/worker_home.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class MyAppRouter {
  static AuthListen authListen = AuthListen();
  static GoRouter goRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      refreshListenable: authListen,
      initialLocation: '/screens/authentication/signup',
      redirect: (context, state) {
        if (!authListen.isSignedIn) {
          if (authListen.user != null) {
            authListen.isSignedIn = true;
            authListen.subscription.cancel();
            return '/screens/worker/homescreen';
          } else {
            authListen.isSignedIn = true;
            authListen.subscription.cancel();
            return null;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/screens/authentication/signup',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SignUpScreen()),
        ),
        GoRoute(
          path: '/screens/authentication/signup/steps/1',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SignUpStep1()),
        ),
        GoRoute(
            path: '/screens/authentication/signup/steps/2',
            pageBuilder: (context, state) {
              print('asdasdasdasdasasdsdaassdasd');
              return const MaterialPage(child: SignUpStep2());
            }),
        GoRoute(
            path: '/screens/authentication/otp',
            pageBuilder: (context, state) =>
                const MaterialPage(child: OtpScreen())),
        GoRoute(
          path: '/screens/worker/homescreen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: WorkerHomeScreen()),
        ),
      ]);
}
