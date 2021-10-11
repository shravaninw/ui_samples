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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black),
        title: const Text(
          'AppBar',
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverList(
                    delegate: SliverChildListDelegate(
                  [
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
                )),
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    const TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(text: "A"),
                        Tab(text: "B"),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(children: [
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
      ),
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
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this.tab);

  final TabBar tab;

  @override
  double get minExtent => tab.preferredSize.height;

  @override
  double get maxExtent => tab.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tab,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
