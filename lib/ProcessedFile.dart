import 'package:flutter/material.dart';
import 'package:new_app/Result.dart';

class ProcessedFile extends StatelessWidget {
  final fileFound;
  final oneDrive;
  ProcessedFile(@required this.fileFound, @required this.oneDrive);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
            Text(fileFound),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Result(oneDrive)));
                },
                child: Text('Back to File location',
                    style: TextStyle(
                      color: Colors.white,
                    )))
          ]))),
    );
  }
}
