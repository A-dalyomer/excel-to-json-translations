import 'package:excel_json_converter/core/dto/selected_file.dart';
import 'package:flutter/material.dart';

import '../../presentation/widget/show_dialog.dart';
import 'export_localization_files.dart';

Future<void> exportDroppedLocalizationFiles(BuildContext context,
    {required List<SelectedFile> droppedFiles}) async {
  List<bool> savingResults = [];
  for (var file in droppedFiles) {
    bool result = await exportLocalizationFiles(context, droppedFile: file);
    savingResults.add(result);
  }
  if (!savingResults.contains(false)) {
    // ignore: use_build_context_synchronously
    showAppDialog(
      'Files saved in downloads path',
      context,
      title: 'saved files successfully',
    );
  }
}
