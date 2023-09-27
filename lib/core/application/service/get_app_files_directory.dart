import 'dart:io';

import 'package:flutter/foundation.dart';

import 'get_platform_directory.dart';

Future<Directory> getAppFilesDirectory({String? fileName}) async {
  final Directory downloadsDirectory = await getPlatformDirectory();

  final appExportFolder = Directory(
    '${downloadsDirectory.path}\\localizations exporter',
  );
  if (!(await appExportFolder.exists())) {
    if (kDebugMode) {
      print('creating target app export folder');
    }
    appExportFolder.create();
    if (kDebugMode) {
      print('done creating app export folder');
    }
  }
  if (fileName == null) return appExportFolder;

  final appLocalizationsFolder = Directory(
    '${appExportFolder.path}\\${fileName.split('.').first}',
  );
  if (!(await appLocalizationsFolder.exists())) {
    if (kDebugMode) {
      print('creating target folder: ${fileName.split('.').first}');
    }
    appLocalizationsFolder.create();
    if (kDebugMode) {
      print('done creating ${fileName.split('.').first}');
    }
  }

  return appLocalizationsFolder;
}
