import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<Directory> getPlatformDirectory() async {
  return (await getDownloadsDirectory()) ??
      await getApplicationDocumentsDirectory();
}
