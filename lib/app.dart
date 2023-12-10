import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:security_enhancer/encryption.dart';
import 'package:security_enhancer/decryption_screen.dart';
import 'dart:async';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 1;
  String theme;
  List<String> mode = ['Light', 'Dark'];
  void uichange(int n) {
    if (n == 0) {
      setState(() {
        theme = "light";
      });
    } else {
      setState(() {
        theme = "dark";
      });
    }
  }

  Future displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.grey,
                title: Text(
                  'Choose Theme',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FlatButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                content: Container(
                  width: double.minPositive,
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: mode.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        activeColor: Colors.black,
                        value: index,
                        groupValue: _currentIndex,
                        title: Text(
                          mode[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            _currentIndex = val;
                            uichange(_currentIndex);
                            print(_currentIndex);
                          });
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme == "light" ? Colors.black : Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: theme == "light" ? Colors.white : Colors.black,
          title: Text(
            "Security Enhancer",
            style: TextStyle(
              color: theme == "light" ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
              labelColor: theme == "light" ? Colors.black : Colors.white,
              indicatorColor: theme == "light" ? Colors.black : Colors.white,
              tabs: [
                Tab(
                  text: "Encrypt",
                ),
                Tab(
                  text: "Decrypt",
                ),
              ]),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.brightness_6),
              color: theme == "light" ? Colors.black : Colors.white,
              onPressed: () {
                displayDialog(context);
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            Encryption(theme: theme),
            Decryption(theme: theme),
          ],
        ),
      ),
    );
  }
}
