import 'package:flutter/material.dart';

import 'package:chatting_app/screens/screens.dart';
import 'package:chatting_app/style/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.dark,
        // themeMode: ThemeMode.light,
        title: 'Chatter',
        home: HomeScreen());
  }
}
