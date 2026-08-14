import 'package:flutter/material.dart';
import 'theme.dart';
import 'routes.dart';

class HealthBridgeApp extends StatelessWidget {
  const HealthBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthBridge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
