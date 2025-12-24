import 'dart:io';
import 'package:excel/excel.dart';
import 'package:excel_json_converter/core/dto/selected_file.dart';
import 'package:excel_json_converter/core/extension/capitalize_first_character.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../dto/saved_file_state.dart';
import 'get_app_files_directory.dart';
import 'save_file.dart';

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

    final List<String> fileNameWords = selectedFile.name.split('.');
    fileNameWords.removeAt(fileNameWords.length - 1);
    String fileName = fileNameWords.join();

    /// prepare save directory
    late Directory saveDirectory;
    if (!kIsWeb) {
      saveDirectory = await getAppFilesDirectory();
    }

    /// read the selected file
    var excel = Excel.decodeBytes(selectedFileAsBytes);

    /// loop tables in files
    /// currently only 1 table is present in file
    for (var table in excel.tables.keys) {
      List<Map<String, String>> allTranslations =
          List.generate(excel.tables[table]!.rows[0].length - 1, (index) => {});

      List<String> localizationKeys = [];
      String dartCode = '';

      /// loop on all excel rows
      for (var row in excel.tables[table]!.rows) {
        String? key = row[0]?.value.toString();
        if (key != null && key.isNotEmpty) {
          localizationKeys.add(key);
          List<String> keyWords = key.replaceAll(' ', '_').split('_');
          String variableName = '';

          /// loop on current key words
          for (int wordIndex = 0; wordIndex < keyWords.length; wordIndex++) {
            keyWords[wordIndex] = keyWords[wordIndex].toLowerCase();
            if (wordIndex != 0) {
              keyWords[wordIndex] = keyWords[wordIndex].capitalizeFirst();
            }
          }
          variableName = keyWords.join();
          if (key == 'continue' || key == 'this') {
            variableName = '${variableName}1';
          }
          dartCode = '$dartCode  String $variableName = "$key";\n';
        } else {
          continue;
        }

        /// loop on row columns
        /// loads translation values
        for (int columnIndex = 1; columnIndex < row.length; columnIndex++) {
          String translationValue = row[columnIndex]!.value.toString();
          allTranslations[columnIndex - 1].addAll({key: translationValue});
        }
      }
      dartCode = 'class AppLocalizations {\n$dartCode}';

      /// export result maps to localization files
      /// export dart code
      await saveFile(
        fileName: fileName,
        fileSavePath: kIsWeb ? '' : saveDirectory.path,
        languagesList: allTranslations,
        dartCode: dartCode,
      );
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
