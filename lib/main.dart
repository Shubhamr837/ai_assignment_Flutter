import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ai_assignment/griditem.dart';
import 'dart:math';
import 'dart:collection';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List tList = [];
  bool pathBuilt = false;
  String text = "Draw Randon obsatcles";

  void _incrementCounter() {}

  final _random = new Random();

/**
 * Generates a positive random integer uniformly distributed on the range
 * from [min], inclusive, to [max], exclusive.
 */
  int next(int min, int max) => min + _random.nextInt(max - min);

  void colorYellowPath(List path) {
    for (int i = 0; i < path.length; i++) {
      tList[path[i]] = 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        height: 600,
        width: 600,
        child: Column(
          children: [
            Container(
              height: 450,
              width: 450,
              color: Colors.black,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 100,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemCount: 100 * 100,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (BuildContext context, int index) {
                    if (pathBuilt == false) {
                      tList.add(0);
                      if (index == (100 * 50 + 1) || index == (100 * 50 + 99)) {
                        tList[index] = 3;
                        if (index == (100 * 50 + 1)) tList[index] = 2;
                        return GridItem(
                          color: Colors.deepPurpleAccent,
                        );
                      }

                      return GridItem(color: Colors.white);
                    } else {
                      int row = index ~/ 100;

                      if (index == (100 * 50 + 1) || index == (100 * 50 + 99))
                        return GridItem(
                          color: Colors.deepPurpleAccent,
                        );
                      if (tList[index] == 1) {
                        return GridItem(
                          color: Colors.red[700],
                        );
                      } else if (tList[index] == 4) {
                        return GridItem(
                          color: Colors.yellow,
                        );
                      } else {
                        return GridItem(color: Colors.white);
                      }
                    }
                  }),
            ),
            Container(
              height: 100,
              width: 100,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                  child: FlatButton(
                      highlightColor: Color.fromRGBO(181, 145, 27, 0),
                      color: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        if (text == "Find Shortest path") {
                          Queue<elementForQue> qu = new Queue();
                          qu.add(elementForQue(100 * 50 + 1, [100 * 50 + 1]));
                          while (qu.isNotEmpty) {
                            elementForQue el = qu.removeFirst();
                            int top = el.element - 100;
                            int down = el.element + 100;
                            int forward = el.element + 1;

                            if (top < 10000 &&
                                top > 0 &&
                                tList[top] != 1 &&
                                tList[top] != 2) {
                              if (tList[top] == 3) {
                                el.path.add(top);
                                colorYellowPath(el.path);
                                setState(() {});
                                return;
                              }
                              tList[top] = 2;
                              List li = new List.from(el.path);
                              li.add(top);
                              qu.add(elementForQue(top, li));
                              print("finding");
                            }
                            if (down < 10000 &&
                                down > 0 &&
                                tList[down] != 1 &&
                                tList[down] != 2) {
                              if (tList[down] == 3) {
                                el.path.add(down);
                                colorYellowPath(el.path);
                                setState(() {});
                                return;
                              }
                              tList[down] = 2;
                              List li = new List.from(el.path);
                              li.add(down);
                              qu.add(elementForQue(down, li));
                            }
                            if (forward < 1000 &&
                                forward > 0 &&
                                tList[forward] != 1 &&
                                tList[forward] != 2) {
                              if (tList[forward] == 3) {
                                el.path.add(forward);
                                colorYellowPath(el.path);
                                setState(() {});
                                return;
                              }
                              tList[forward] = 2;
                              List li = new List.from(el.path);
                              li.add(forward);
                              qu.add(elementForQue(forward, li));
                            }
                          }
                          return;
                        }
                        int last = 0;

                        for (int j = 0; j < 30; j++) {
                          int rand = next(-1, 4);

                          int index = j * 100 + 30 + rand + last;
                          while (index >= 10000) index--;
                          tList[index] = 1;
                          last = rand;
                        }
                        last = 0;

                        for (int j = 20; j < 60; j++) {
                          int rand = next(-1, 4);

                          int index = j * 100 + 60 + rand + last;
                          while (index >= 10000) index--;
                          tList[index] = 1;

                          last = rand;
                        }

                        last = 0;

                        for (int j = 0; j < 30; j++) {
                          int rand = next(-1, 4);

                          int index = (100 - j) * 100 + 30 + rand + last;
                          while (index >= 10000) index--;
                          tList[index] = 1;
                          last = rand;
                        }

                        last = 0;

                        for (int j = 20; j < 60; j++) {
                          int rand = next(-1, 4);

                          int index = (100 - j) * 100 + 80 + rand + last;
                          while (index >= 10000) index--;
                          tList[index] = 1;
                          last = rand;
                        }

                        last = 0;
                        pathBuilt = true;
                        setState(() {
                          text = "Find Shortest path";
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 2, top: 2, bottom: 2),
                        child: Center(
                            child: Text(
                          text,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        )),
                      ))),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class elementForQue {
  elementForQue(this.element, this.path);
  List path;
  int element;
}
