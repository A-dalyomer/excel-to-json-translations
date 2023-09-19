import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../presentation/widget/show_dialog.dart';
import 'export_localization_files.dart';

Future<void> exportDroppedLocalizationFiles(BuildContext context,
    {required List<Uint8List> droppedFiles}) async {
  for (var file in droppedFiles) {
    await exportLocalizationFiles(context, droppedFile: file);
  }
  // ignore: use_build_context_synchronously
  showAppDialog(
    'Files saved in downloads path',
    context,
    title: 'saved files successfully',
  );
}
