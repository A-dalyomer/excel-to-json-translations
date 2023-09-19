import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:excel_json_converter/core/dto/selected_file.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dto/saved_file_state.dart';
import 'get_app_files_directory.dart';

Future<SavedFileState> exportLocalizationFiles(BuildContext context,
    {SelectedFile? targetFile}) async {
  try {
    /// pick Excel file
    SelectedFile? selectedFile = targetFile;
    if (selectedFile == null) return SavedFileState(fileState: FileState.none);

    Uint8List? selectedFileAsBytes = selectedFile.fileBytes;
    if (selectedFileAsBytes == null) {
      return SavedFileState(fileState: FileState.none);
    }

    /// prepare save directory
    Directory saveDirectory =
        await getAppFilesDirectory(fileName: selectedFile.name);

    /// read the selected file
    var excel = Excel.decodeBytes(selectedFileAsBytes);

    /// loop tables in files
    /// currently only 1 table is present in file
    for (var table in excel.tables.keys) {
      List<Map<String, String>> allTranslations =
          List.generate(excel.tables[table]!.rows[0].length - 1, (index) => {});

      /// loop on all excel rows
      for (var row in excel.tables[table]!.rows) {
        String key = row[0]!.value.toString();

        /// loop on row columns
        /// loads translation values
        for (int columnIndex = 1; columnIndex < row.length; columnIndex++) {
          String translationValue = row[columnIndex]!.value.toString();
          allTranslations[columnIndex - 1].addAll({key: translationValue});
        }
      }

      /// export result maps to localization files
      for (var languageMap in allTranslations) {
        String languageCode = languageMap['language_code'] ?? 'unknown';
        if (kIsWeb) {
          await FileSaver.instance.saveFile(
            name: '$languageCode.json',
            bytes: Uint8List.fromList(jsonEncode(languageCode).codeUnits),
          );
        } else {
          String filePath = "${saveDirectory.path}\\$languageCode.json";
          File(filePath).writeAsStringSync(jsonEncode(languageMap));
        }
      }
    }
    return SavedFileState(
      fileState: FileState.success,
      savedDirectory: kIsWeb ? 'Downloads' : saveDirectory.path,
    );
  } catch (exception) {
    return SavedFileState(
      fileState: FileState.error,
      errorMessage: exception.toString(),
    );
  }
}
