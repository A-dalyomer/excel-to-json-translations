import 'dart:io';

import 'package:excel_json_converter/core/dto/saved_file_state.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

Future<void> logFileExportEventEvent({
  required List<SavedFileState> fileState,
}) async {
  try {
    await FirebaseAnalytics.instance.logEvent(
      name: 'export_operation',
      callOptions: AnalyticsCallOptions(global: true),
      parameters: {
        'errors': fileState.first.fileState.name,
        'platform': kIsWeb ? 'web' : Platform.operatingSystem,
        'success_count': fileState
            .where((element) => element.fileState == FileState.success)
            .length,
      },
    );
  } catch (exception) {
    // ignore
  }
}
