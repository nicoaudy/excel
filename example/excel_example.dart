import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

void main(List<String> args) {
  var file = "/Users/kawal/Desktop/form.xlsx";
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.createExcel();
  // or
  //var excel = Excel.decodeBytes(bytes);
  for (var table in excel.tables.keys) {
    print(table);
    print(excel.tables[table].maxCols);
    print(excel.tables[table].maxRows);
    for (var row in excel.tables[table].rows) {
      print("$row");
    }
  }

  CellStyle cellStyle = CellStyle(
    bold: true,
    italic: true,
    fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
  );

  var sheet = excel['mySheet'];

  var cell = sheet.cell(CellIndex.indexByString("A1"));
  cell.value = "Heya How are you I am fine ok goood night";
  cell.cellStyle = cellStyle;

  var cell2 = sheet.cell(CellIndex.indexByString("A5"));
  cell2.value = "Heya How night";
  cell2.cellStyle = cellStyle;

  /// printing cell-type
  print("CellType: " + cell.cellType.toString());

  excel.rename("mySheet", "myRenamedNewSheet");

  // fromSheet should exist in order to sucessfully copy the contents
  excel.copy('myRenamedNewSheet', 'toSheet');

  excel.rename('oldSheetName', 'newSheetName');

  excel.delete('Sheet1');

  excel.unLink('sheet1');

  sheet = excel['sheet'];

  /// appending rows
  sheet.appendRow([8]);
  excel.setDefaultSheet(sheet.sheetName).then((isSet) {
    // isSet is bool which tells that whether the setting of default sheet is successful or not.
    if (isSet) {
      print("${sheet.sheetName} is set to default sheet.");
    } else {
      print("Unable to set ${sheet.sheetName} to default sheet.");
    }
  });

  // Saving the file

  String outputFile = "/Users/kawal/Desktop/form1.xlsx";
  excel.encode().then((onValue) {

    File(join(outputFile))
      ..createSync(recursive: true)
      ..writeAsBytesSync(onValue);
  });
}
