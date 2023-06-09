import 'dart:convert';
import 'dart:io';

import 'CaloriesImporter.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

class SamsungCaloriesImporter extends CaloriesImporter {
  SamsungCaloriesImporter(File file) : super(file);

  Future<int> getCaloriesAverage(DateTime from) async {
    try {
      int result = 0;
      List<int> values = <int>[];

      PermissionStatus status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      final input = this.file.openRead();
      final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter(eol: "\n")).toList();

      Map dataMap = new Map();

      for (int i = 2; i < fields.length - 1; i++) {
        DateTime current = DateTime.parse(fields[i][7]).add(new Duration(minutes: 59));

        if (from.isAfter(current)) {
          continue;
        }

        //String key = current.day.toString() + "." + current.month.toString() + "." + current.year.toString();
        String key = "${current.day}.${current.month}.${current.year}";

        if (!dataMap.containsKey(key) || current.isAfter(dataMap[key]["date"])) {
          dataMap[key] = {"date": current, "value": fields[i][11]};
        }
      }

      dataMap.forEach((key, value) {
        values.add((value["value"] as double).floor());
      });

      result = this.calculateAverage(values);

      return result;
    } catch (e) {
      print(e);
      return -1;
    }
  }
}
