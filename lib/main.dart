import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';

void main() async {
  String file = "assets/gifts app localization.xlsx";
  var bytes = File(file).readAsBytesSync();
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
      String file = "assets/$languageCode.json";
      File(file).writeAsStringSync(jsonEncode(languageMap));
    }
  }
}
