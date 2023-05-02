import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:excel_json_converter/show_dialog.dart';
import 'package:flutter/material.dart';

import 'get_export_directory.dart';
import 'pick_localization_file.dart';

void exportLocalizationFiles(BuildContext context) async {
  try {
    /// pick Excel file
    File? selectedFile = await pickLocalizationsFile();
    if (selectedFile == null) return;

    /// prepare save directory
    Directory downloadsDirectory = await getExportDirectory();

    /// read the selected file
    var bytes = selectedFile.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

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
        String filePath = "${downloadsDirectory.path}\\$languageCode.json";
        File(filePath).writeAsStringSync(jsonEncode(languageMap));
      }
    }
    // ignore: use_build_context_synchronously
    showAppDialog('File saved in path: ${downloadsDirectory.path}', context,
        title: 'saved files successfully');
  } catch (exception) {
    showAppDialog('error: $exception', context);
  }
}
