import 'package:flutter/material.dart';
import 'package:flutter_onedrive/flutter_onedrive.dart';
import 'package:new_app/ProcessedFile.dart';
import 'package:excel/excel.dart';

class Result extends StatelessWidget {
  final OneDrive oneDrive;
  Result(@required this.oneDrive);

  @override
  Widget build(BuildContext context) {
    var inputfileName = null;
    return (Scaffold(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProcessedFile("file found", oneDrive)));
                print("file found");
                var excel = Excel.decodeBytes(bytes);

                for (var table in excel.tables.keys) {
                  print(table); //sheet Name
                  var sheetData = excel.tables[table];
                  if (sheetData != null) {
                    print(sheetData.maxCols);
                    print(sheetData.maxRows);
                    for (var row in sheetData.rows) {
                      print("$row");
                    }
                  }
                }
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
