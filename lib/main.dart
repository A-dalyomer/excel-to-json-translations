import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';

void main() async {
  String file = "assets/gifts app localization.xlsx";
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    Map<String, String> localeMap = {};
    for (var row in excel.tables[table]!.rows) {
      String key = row[0]!.value.toString();
      String englishValue = row[1]!.value.toString();
      localeMap.addAll({key: englishValue});
    }

    String file = "assets/english.json";
    File(file).writeAsStringSync(jsonEncode(localeMap));
  }
}
