import 'package:aguilera_gate_control/control_commands.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:aguilera_gate_control/automatic_gate_operation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  FlutterAppBadger.removeBadge(); // Remove the badge on startup
  runApp(MyApp());
}
  class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aguilera Gate Control',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.accent
        ),
      ),
      home: ControlCommands(),
    );
  } // build
} // MyApp
