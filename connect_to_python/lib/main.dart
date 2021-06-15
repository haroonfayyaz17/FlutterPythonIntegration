import 'dart:convert';

import 'package:flutter/material.dart';
import 'PythonController.dart';
import 'URLController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  URLs _urls;
  String _text = 'Hello';
  String _valueEntered;
  var jsonResponse;
  var jsonLength = 0;
  var Data;
  @override
  Widget build(BuildContext context) {
    _urls = new URLs();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 200,
                child: TextField(
                  onChanged: (value) {
                    _valueEntered = value;
                  },
                ),
              ),
              Container(
                width: 60,
                height: 20,
                child: Text(
                  _text,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  var url = _urls.url +
                      _urls.extensionHelloWorld +
                      '?value=' +
                      _valueEntered;
                  Data = await GetData(url);
                  if (Data.statusCode == 200) {
                    setState(() {
                      jsonResponse = jsonDecode(Data.body);
                      jsonLength = jsonResponse.length;
                    });
                  } else {
                    setState(() {
                      jsonLength = 0;
                    });
                  }
                },
                child: Container(height: 30, width: 50, child: Text('Press')),
              ),
              Expanded(
                child: Container(
                  width: jsonLength == 0 ? 50 : 350,
                  child: jsonLength == 0
                      ? Text('Loading....')
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: jsonLength,
                          itemBuilder: (context, int index) {
                            return Card(
                              child: Row(
                                children: [
                                  Container(
                                      width: 50,
                                      child: Text(jsonResponse[index]['value']
                                          .toString())),
                                  Container(
                                      width: 50,
                                      child: Text(jsonResponse[index]
                                              ['multiplier']
                                          .toString())),
                                  Container(
                                      width: 50,
                                      child: Text(jsonResponse[index]['result']
                                          .toString())),
                                ],
                              ),
                            );
                          }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
