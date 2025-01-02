import 'dart:async';
import 'package:flutter/material.dart';
import 'app.dart';

FutureOr<void> main() async {
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  runApp(const App());
}
