import 'dart:io';
import 'package:excel_json_converter/core/dto/selected_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

Future<SelectedFile?> pickLocalizationsFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    if (!kIsWeb) {
      return SelectedFile(
        name: result.files.single.name,
        fileBytes: File(result.files.single.path!).readAsBytesSync(),
      );
    }

    return SelectedFile(
      name: result.files.single.name,
      fileBytes: result.files.single.bytes,
    );
  } else {
    return null;
  }
}
