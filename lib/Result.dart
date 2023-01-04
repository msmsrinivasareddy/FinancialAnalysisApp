import 'package:flutter/material.dart';
import 'package:flutter_onedrive/flutter_onedrive.dart';
import 'package:new_app/ProcessedFile.dart';
import 'package:excel/excel.dart';
import 'package:new_app/welcome.dart';

class Result extends StatelessWidget {
  final OneDrive oneDrive;
  Result(@required this.oneDrive);

  @override
  Widget build(BuildContext context) {
    var inputfileName = null;
    return (Scaffold(
        appBar: AppBar(
          title: const Text('Finance App'),
          backgroundColor: Colors.green,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text("Sucessfully logged in, Please enter file location"),
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'File Location'),
                  onChanged: (value) {
                    inputfileName = value;
                  }),
              ElevatedButton(
                onPressed: () async {
                  final bytes = await oneDrive.pull(inputfileName);
                  if (bytes != null && !bytes.isEmpty) {
                    print("file found");
                    var excel = Excel.decodeBytes(bytes);
                    final List<ChartData> assetData = <ChartData>[];
                    final List<ChartData> liabilityData = <ChartData>[];

                    for (var table in excel.tables.keys) {
                      print(table); //sheet Name
                      var sheetData = excel.tables[table];
                      if (sheetData != null) {
                        print(sheetData.maxCols);
                        print(sheetData.maxRows);
                        var rows = sheetData.rows;
                        if (rows != null && rows.isNotEmpty) {
                          rows.removeAt(0);
                        }
                        for (var row in rows) {
                          var sheetName = sheetData.sheetName;
                          if (sheetName.toLowerCase() == "assets") {
                            var month = "";
                            var amount = 0;
                            for (var coloumn in row) {
                              if (null != coloumn && 0 == coloumn.colIndex) {
                                month = coloumn.value.toString();
                              }
                              if (null != coloumn && 1 == coloumn.colIndex) {
                                amount = coloumn.value;
                              }
                            }
                            ChartData newChartData =
                                new ChartData(month, amount);
                            assetData.add(newChartData);
                          }
                          if (sheetName.toLowerCase() == "liabilities") {
                            var month = "";
                            var amount = 0;
                            var color = Colors.green;
                            for (var coloumn in row) {
                              if (null != coloumn && 0 == coloumn.colIndex) {
                                month = coloumn.value.toString();
                              }
                              if (null != coloumn && 1 == coloumn.colIndex) {
                                amount = coloumn.value;
                              }
                            }
                            ChartData newChartData =
                                new ChartData(month, amount);
                            liabilityData.add(newChartData);
                          }
                        }
                      }
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Welcome(assetData, liabilityData)));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProcessedFile("file not found", oneDrive)));
                  }
                },
                child: Text(
                  'Access File',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ]))));
  }
}
