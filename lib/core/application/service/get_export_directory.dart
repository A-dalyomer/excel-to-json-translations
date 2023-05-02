import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory> getExportDirectory() async {
  return (await getDownloadsDirectory()) ??
      await getApplicationDocumentsDirectory();
}
