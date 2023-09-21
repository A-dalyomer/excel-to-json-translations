import 'dart:convert';
import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';

Future<void> saveFile({
  required String fileSavePath,
  required String fileName,
  required fileExtension,
  required fileContent,
}) async {
  String contentToWrite =
      fileExtension == 'json' ? jsonEncode(fileContent) : fileContent;
  if (kIsWeb) {
    await FileSaver.instance.saveFile(
      name: '$fileName.$fileExtension',
      bytes: Uint8List.fromList(contentToWrite.codeUnits),
    );
  } else {
    String filePath = "$fileSavePath\\$fileName.$fileExtension";
    File(filePath).writeAsStringSync(contentToWrite);
  }
}
