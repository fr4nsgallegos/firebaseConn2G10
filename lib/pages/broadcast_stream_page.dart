import 'dart:async';

import 'package:flutter/material.dart';

class BroadcastStreamPage extends StatefulWidget {
  @override
  State<BroadcastStreamPage> createState() => _BroadcastStreamPageState();
}

class _BroadcastStreamPageState extends State<BroadcastStreamPage> {
  //CREANDO STREAMCONTROLLER EN MODO BROADCAST
  final StreamController<String> _controller =
      StreamController<String>.broadcast();

  @override
  void dispose() {
    _controller.close();
    // TODO: implement dispose
    super.dispose();
  }

  void emitEvents() {
    _controller.add("event 1");
    _controller.add("event 2");
    // _controller.add("event 3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Single Stream Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                emitEvents();
              },
              child: Text("Emitir eventos"),
            ),
            StreamListenerWidget(_controller), //primer oyente
            StreamListenerWidget(_controller), //segund oyente
          ],
        ),
      ),
    );
  }
}

class StreamListenerWidget extends StatelessWidget {
  final StreamController<String> controller;
  StreamListenerWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: controller.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            return Text("Escuchando: ${snapshot.data}");
          } else {
            return Text("No hay eventos ");
          }
        },
      ),
    );
  }
}
