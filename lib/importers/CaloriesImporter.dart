import 'dart:io';

class CaloriesImporter {
  File file;

  CaloriesImporter(this.file);

  int calculateAverage(List<int> values) {
    int average = 0;
    values.forEach((element) {
      average += element;
    });
    average = (average / values.length).floor();
    return average;
  }

  static Future<String> getFileType(File file) async {
    return file.readAsStringSync().startsWith("com.samsung")
        ? "Samsung"
        : "Google";
  }
}
