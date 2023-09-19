import 'package:excel_json_converter/core/dto/selected_file.dart';
import 'package:flutter/material.dart';

import '../../dto/saved_file_state.dart';
import '../../presentation/widget/show_dialog.dart';
import 'export_localization_files.dart';

Future<void> exportMultiAppLocalizationFiles(
  BuildContext context, {
  required List<SelectedFile> filesList,
}) async {
  List<SavedFileState> savingResults = [];
  for (var file in filesList) {
    SavedFileState result =
        await exportLocalizationFiles(context, targetFile: file);
    savingResults.add(result);
  }

  String viewedResults = '';
  for (var item in savingResults) {
    viewedResults =
        '$viewedResults${item.fileState.name} : ${item.errorMessage ?? item.savedDirectory}\n';
  }
  // ignore: use_build_context_synchronously
  showAppDialog(
    'Files result\n$viewedResults',
    context,
    title: 'Done processing files',
  );
}
