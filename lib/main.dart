import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'localizations_app.dart';

void main() async {
  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? DefaultFirebaseOptions.currentPlatform
        : DefaultFirebaseOptions.web,
  );

  runApp(const LocalizationsApp());
}
