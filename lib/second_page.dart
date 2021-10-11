// ignore_for_file: unused_local_variable

import 'dart:isolate';

import 'package:flutter/material.dart';

class ImageSection extends StatefulWidget {
  const ImageSection({Key? key}) : super(key: key);

  @override
  _ImageSectionState createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  bool showSum = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            InteractiveViewer(
                minScale: 0.1,
                maxScale: 1.5,
                child: Image.asset('assets/image.jpg')),
            ElevatedButton(
                onPressed: () async {
                  print('onpressed ${Isolate.current.debugName}');
                  var receivePort = ReceivePort();
                  await Isolate.spawn(echo, receivePort.sendPort);

                  var sendPort = await receivePort.first;
                  int sum = await sendReceive(sendPort, [1, 5, 2, 3, 7]);
                  print('received $sum');

                  final snackBar = SnackBar(
                    content: Text('Sum=$sum'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () async {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text('sum'))
          ],
        ),
      ),
    );
  }
}

echo(SendPort sendPort) async {
  print('echo ${Isolate.current.debugName}');
  // Open the ReceivePort for incoming messages.
  var port = ReceivePort();
  // Notify any other isolates what port this isolate listens to.
  num sum = 0;
  sendPort.send(port.sendPort);
  await for (var msg in port) {
    var data = msg[0];
    for (int i = 0; i < data.length; i++) {
      sum += data[i];
    }
    print('data $sum');
    SendPort replyTo = msg[1];
    replyTo.send(sum);
  }
}

/// sends a message on a port, receives the response,
/// and returns the message
Future sendReceive(SendPort port, msg) {
  ReceivePort response = ReceivePort();
  port.send([msg, response.sendPort]);
  return response.first;
}
