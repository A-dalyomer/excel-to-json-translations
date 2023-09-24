import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'localizations_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb
        ? DefaultFirebaseOptions.web
        : Platform.isAndroid
            ? DefaultFirebaseOptions.currentPlatform
            : DefaultFirebaseOptions.web,
  );
  await FirebaseAnalytics.instance.logAppOpen();

  runApp(const LocalizationsApp());
}
