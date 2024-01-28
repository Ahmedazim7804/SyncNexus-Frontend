import 'package:flutter/material.dart';
import 'package:worker_app/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: MyAppRouter.goRouter.routeInformationParser,
      routeInformationProvider: MyAppRouter.goRouter.routeInformationProvider,
      routerDelegate: MyAppRouter.goRouter.routerDelegate,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 226, 181, 31)),
        useMaterial3: true,
      ),
    );
  }
}
