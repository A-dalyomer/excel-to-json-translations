import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';

Future<void> saveFile({
  required String fileSavePath,
  required String fileName,
  required List<Map<String, String>> languagesList,
  String? dartCode,
}) async {
  final Archive archive = Archive();

  for (var languageLocales in languagesList) {
    String languageCode = languageLocales['language_code'] ?? 'unknown';
    String contentToWrite = jsonEncode(languageLocales);

    /// add language localizations file to zip archive
    final ArchiveFile archiveFile = ArchiveFile(
      '$languageCode.json',
      contentToWrite.length,
      contentToWrite,
    );
    archive.addFile(archiveFile);
  }

  /// add dart code class file to zip archive
  if (dartCode != null) {
    final ArchiveFile archiveFile = ArchiveFile(
      'app_localizations.dart',
      dartCode.length,
      dartCode,
    );
    archive.addFile(archiveFile);
  }

  /// encode zip file
  ZipEncoder encoder = ZipEncoder();
  final encodedArchive = encoder.encode(archive);
  if (encodedArchive == null) return;

  /// save the file

  if (kIsWeb) {
    await FileSaver.instance.saveFile(
      name: '$fileName.zip',
      bytes: Uint8List.fromList(encodedArchive),
    );
  } else {
    String filePath = "$fileSavePath\\$fileName.zip";
    File(filePath).writeAsBytesSync(encodedArchive);
  }
}
