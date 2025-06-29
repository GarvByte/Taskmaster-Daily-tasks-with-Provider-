import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/helpers/provider.dart';
import 'package:todo_app/pages/home_page.dart';
// Update this import path

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox('hivebox');
 // Open box before app runs

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppStateModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Newpage(),
      ),
    ),
  );
}
