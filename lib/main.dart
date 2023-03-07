import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_flutter/app.dart';

void main() {
  runApp(ProviderScope(child: const App()));
}
