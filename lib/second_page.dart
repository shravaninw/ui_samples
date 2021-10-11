import 'dart:isolate';

import 'package:flutter/material.dart';


class ImageSection extends StatefulWidget {
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
  // Open the ReceivePort for incoming messages.
  var port = ReceivePort();
  // Notify any other isolates what port this isolate listens to.
  sendPort.send(port.sendPort);
  await for (var msg in port) {
    var data = msg[0];
    print('data $data');
    SendPort replyTo = msg[1];
    replyTo.send(data);
  }
}

/// sends a message on a port, receives the response,
/// and returns the message
Future sendReceive(SendPort port, msg) {
  print(msg);
  ReceivePort response = ReceivePort();
  num sum = 0;
  for (int i = 0; i < msg.length; i++) {
    sum = sum + msg[i];
  }
  port.send([sum, response.sendPort]);
  return response.first;
}
