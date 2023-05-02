import 'package:flutter/material.dart';

import 'core/presentation/screen/home_screen.dart';

class LocalizationsApp extends StatelessWidget {
  const LocalizationsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
