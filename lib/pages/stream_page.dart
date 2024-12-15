import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  final StreamController<int> _streamController = StreamController<int>();

  int _counter = 0;

  @override
  void dispose() {
    _streamController.close(); //cerramos el streamcontroller
    // TODO: implement dispose
    super.dispose();
  }

  void _incrementCounter() {
    _counter++;
    _streamController.add(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Stream Page"),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _streamController.stream,
          initialData: _counter,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text("ERROR: ${snapshot.error}");
            }
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Text(
              "COUNTER: ${snapshot.data}",
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
