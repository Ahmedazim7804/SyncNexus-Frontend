import 'package:flutter/material.dart';
import 'package:worker_app/bloc/cubit/job_cubit.dart';
import 'package:worker_app/router/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider(
      create: (context) => JobCubit(),
      child: MaterialApp.router(
        routeInformationParser: MyAppRouter.goRouter.routeInformationParser,
        routeInformationProvider: MyAppRouter.goRouter.routeInformationProvider,
        routerDelegate: MyAppRouter.goRouter.routerDelegate,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 226, 181, 31)),
          useMaterial3: true,
        ),
      ),
    ),
  );
}
