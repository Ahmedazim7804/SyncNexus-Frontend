import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker_app/models/employee_model.dart';
import 'package:worker_app/provider/uid_provider.dart';
import 'package:worker_app/router/auth_listenable.dart';
import 'package:worker_app/ui/screens/authentication/otp_screen.dart';
import 'package:worker_app/ui/screens/authentication/signup_screen.dart';
import 'package:worker_app/ui/screens/authentication/steps/signup_step_1.dart';
import 'package:worker_app/ui/screens/authentication/steps/signup_step_2.dart';
import 'package:worker_app/ui/screens/authentication/steps/user_details_screen.dart';
import 'package:worker_app/ui/screens/employer_screen/employee_tasks_screen.dart';
import 'package:worker_app/ui/screens/employer_screen/employees_list_screen.dart';
import 'package:worker_app/ui/screens/employer_screen/employer_homescreen.dart';
import 'package:worker_app/ui/screens/employer_screen/employer_payment.dart';
import 'package:worker_app/ui/screens/employer_screen/employer_root_scaffold.dart';
import 'package:worker_app/ui/screens/employer_screen/jobs_list_screen.dart';
import 'package:worker_app/ui/screens/employer_screen/profile_screen.dart';

import 'package:worker_app/ui/screens/worker_screen/worker_home.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorEmployerDashboardKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellEmployerDashboard');
final _shellNavigatorEmployerJobsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellEmployerJobs');
final _shellNavigatorEmployerPaymentKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellEmployerPayment');
final _shellNavigatorEmployerProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellEmployerProfile');

class MyAppRouter {
  static AuthListen authListen = AuthListen();
  static GoRouter goRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      refreshListenable: authListen,
      initialLocation:
          '/screens/authentication/other', //'/screens/authentication/signup',
      redirect: (context, state) {
        if (!authListen.isSignedIn) {
          if (authListen.user != null) {
            context.read<UidProvider>().uid = authListen.user!.uid;
            authListen.isSignedIn = true;
            authListen.subscription.cancel();

            try {
              if (context.read<SharedPreferences>().getBool('employee')!) {
                return '/screens/worker/homescreen';
              } else {
                return '/screens/employer/homescreen';
              }
            } catch (e) {
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
        StatefulShellRoute.indexedStack(
            builder: (context, state, child) =>
                EmployerRootScaffold(child: child),
            branches: [
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorEmployerDashboardKey,
                  routes: [
                    GoRoute(
                      path: '/screens/employer/employees',
                      pageBuilder: (context, state) =>
                          const MaterialPage(child: EmployeesListScreen()),
                    ),
                    GoRoute(
                        path: '/screens/employer/employee',
                        pageBuilder: (context, state) {
                          Employee employee = state.extra as Employee;
                          return MaterialPage(
                              child: EmployeeTaskListScreen(
                            employee: employee,
                          ));
                        }),
                    GoRoute(
                      path: '/screens/employer/homescreen',
                      pageBuilder: (context, state) =>
                          const MaterialPage(child: EmployerHomeScreen()),
                    ),
                  ]),
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorEmployerJobsKey,
                  routes: [
                    GoRoute(
                      path: '/screens/employer/jobs',
                      pageBuilder: (context, state) =>
                          const MaterialPage(child: JobsListScreen()),
                    ),
                  ]),
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorEmployerPaymentKey,
                  routes: [
                    GoRoute(
                      path: '/screens/employer/payment',
                      pageBuilder: (context, state) =>
                          const MaterialPage(child: EmployerPaymentScreen()),
                    ),
                  ]),
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorEmployerProfileKey,
                  routes: [
                    GoRoute(
                      path: '/screens/employer/profile',
                      pageBuilder: (context, state) =>
                          const MaterialPage(child: EmployerProfileScreen()),
                    ),
                  ]),
            ]),
        GoRoute(
          path: '/screens/authentication/signup',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SignUpScreen()),
        ),
        GoRoute(
          path: '/screens/authentication/other',
          pageBuilder: (context, state) =>
              const MaterialPage(child: OthersDetailScreen()),
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
      ]);
}
