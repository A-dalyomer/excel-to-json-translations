import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:excel_json_converter/core/dto/selected_file.dart';
import 'package:excel_json_converter/core/presentation/widget/show_dialog.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'get_export_directory.dart';
import 'pick_localization_file.dart';

Future<bool> exportLocalizationFiles(BuildContext context,
    {SelectedFile? droppedFile}) async {
  try {
    /// pick Excel file
    SelectedFile? selectedFile = droppedFile ?? await pickLocalizationsFile();
    if (selectedFile == null) return false;

    Uint8List? selectedFileAsBytes = selectedFile.fileBytes;
    if (selectedFileAsBytes == null) return false;

    /// prepare save directory
    late final Directory downloadsDirectory;
    if (!kIsWeb) {
      downloadsDirectory = await getExportDirectory();
    }

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
          final appLocalizationsFolder = Directory(
            '${appExportFolder.path}\\${selectedFile.name.split('.').first}',
          );
          if (!(await appLocalizationsFolder.exists())) {
            if (kDebugMode) {
              print(
                  'creating target folder: ${selectedFile.name.split('.').first}');
            }
            appLocalizationsFolder.create();
            if (kDebugMode) {
              print('done creating ${selectedFile.name.split('.').first}');
            }
          }
          String filePath =
              "${appLocalizationsFolder.path}\\$languageCode.json";
          File(filePath).writeAsStringSync(jsonEncode(languageMap));
        }
      }
    }
    if (droppedFile == null) {
      // ignore: use_build_context_synchronously
      showAppDialog(
        'File saved in path: ${kIsWeb ? 'Downloads' : downloadsDirectory.path}',
        context,
        title: 'saved files successfully',
      );
    }
    return true;
  } catch (exception) {
    showAppDialog('error: $exception', context);
    return false;
  }
}
