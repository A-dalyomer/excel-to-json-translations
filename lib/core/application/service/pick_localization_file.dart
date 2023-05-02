import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<Uint8List?> pickLocalizationsFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    return result.files.single.bytes;
  } else {
    return null;
  }
}
