import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

Future<Uint8List?> pickLocalizationsFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    if (!kIsWeb) {
      return File(result.files.single.path!).readAsBytesSync();
    }
    return result.files.single.bytes;
  } else {
    return null;
  }
}
