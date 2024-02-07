import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker_app/provider/uid_provider.dart';
import 'package:worker_app/router/auth_listenable.dart';
import 'package:worker_app/ui/screens/authentication/otp_screen.dart';
import 'package:worker_app/ui/screens/authentication/signup_screen.dart';
import 'package:worker_app/ui/screens/authentication/steps/signup_step_1.dart';
import 'package:worker_app/ui/screens/authentication/steps/signup_step_2.dart';
import 'package:worker_app/ui/screens/employer_screen/employee_tasks_screen.dart';
import 'package:worker_app/ui/screens/employer_screen/employees_list_screen.dart';
import 'package:worker_app/ui/screens/employer_screen/employer_homescreen.dart';
import 'package:worker_app/ui/screens/employer_screen/jobs_list_screen.dart';
import 'package:worker_app/ui/screens/employer_screen/profile_screen.dart';

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
            context.read<UidProvider>().uid = authListen.user!.uid;
            authListen.isSignedIn = true;
            authListen.subscription.cancel();

            if (context.read<SharedPreferences>().getBool('employee')!) {
              return '/screens/worker/homescreen';
            } else {
              return '/screens/employer/homescreen';
            }
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
            name: '/screens/authentication/signup/steps/1',
            path: '/screens/authentication/signup/steps/1/:uid',
            pageBuilder: (context, state) {
              String uid = state.pathParameters['uid']!;
              return MaterialPage(child: SignUpStep1(uid: uid));
            }),
        GoRoute(
            path: '/screens/authentication/signup/steps/2',
            pageBuilder: (context, state) {
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
        GoRoute(
          path: '/screens/employer/employees',
          pageBuilder: (context, state) =>
              const MaterialPage(child: EmployeesListScreen()),
        ),
        GoRoute(
          path: '/screens/employer/jobs',
          pageBuilder: (context, state) =>
              const MaterialPage(child: JobsListScreen()),
        ),
        GoRoute(
          path: '/screens/employer/profile',
          pageBuilder: (context, state) =>
              const MaterialPage(child: EmployerProfileScreen()),
        ),
        GoRoute(
          path: '/screens/employer/employee',
          pageBuilder: (context, state) =>
              const MaterialPage(child: EmployeeTaskListScreen()),
        ),
        GoRoute(
          path: '/screens/employer/homescreen',
          pageBuilder: (context, state) =>
              const MaterialPage(child: EmployerHomeScreen()),
        ),
      ]);
}
