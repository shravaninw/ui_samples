import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uidemo/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var colors = [
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.blue,
    Colors.indigo,
    Colors.tealAccent
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(color: Colors.black),
            title: const Text(
              'AppBar',
            ),
          ),
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(
                child: Container(
              height: 180,
              child: ListView(
                children: [
                  Container(
                      height: 60,
                      color: colors[0],
                      child: const Text('Random Height Child 1')),
                  Container(
                      height: 60,
                      color: colors[1],
                      child: const Text('Random Height Child 2')),
                  Container(
                      height: 60,
                      color: colors[2],
                      child: const Text('Random Height Child 3')),
                ],
              ),
            )),
            SliverToBoxAdapter(
              child: TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(text: "A"),
                  Tab(text: "B"),
                ],
              ),
            ),
            SliverFillRemaining(
                child: TabBarView(children: [
              GridView.builder(
                  itemCount: 30,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    );
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 80,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    );
                  })
            ])),
          ]),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ImageSection(),
                  ),
                );
              }),
        ));
  }
}
