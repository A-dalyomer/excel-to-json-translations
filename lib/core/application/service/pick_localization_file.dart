import 'dart:io';
import 'package:excel_json_converter/core/application/service/export_dropped_files.dart';
import 'package:excel_json_converter/core/dto/selected_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Future<void> pickLocalizationsFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
  );

  if (result != null) {
    // ignore: use_build_context_synchronously
    await exportMultiAppLocalizationFiles(
      context,
      filesList: result.files.map((e) {
        return SelectedFile(
          name: e.name,
          fileBytes: kIsWeb ? e.bytes : File(e.path!).readAsBytesSync(),
        );
      }).toList(),
    );
  }
}
