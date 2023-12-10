import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:clipboard/clipboard.dart';
import 'dart:async';

class Decryption extends StatefulWidget {
  final String theme;
  Decryption({this.theme});
  @override
  _DecryptionState createState() => _DecryptionState();
}

class _DecryptionState extends State<Decryption> {
  String dec = "";
  String res = "";
  String n = "";
  var l = new List();
  final tc = TextEditingController();
  var d = {
    '.-': 'A',
    '-...': 'B',
    '-.-.': 'C',
    '-..': 'D',
    '.': 'E',
    '..-.': 'F',
    '--.': 'G',
    '....': 'H',
    '..': 'I',
    '.---': 'J',
    '-.-': 'K',
    '.-..': 'L',
    '--': 'M',
    '-.': 'N',
    '---': 'O',
    '.--.': 'P',
    '--.-': 'Q',
    '.-.': 'R',
    '...': 'S',
    '-': 'T',
    '..-': 'U',
    '...-': 'V',
    '.--': 'W',
    '-..-': 'X',
    '-.--': 'Y',
    '--..': 'Z',
    '.----': '1',
    '..---': '2',
    '...--': '3',
    '....-': '4',
    '.....': '5',
    '-....': '6',
    '--...': '7',
    '---..': '8',
    '----.': '9',
    '-----': '0',
    '.-.-.-': '.',
    '--..--': ',',
    '..--..': '?',
    '.----.': '‘',
    '.-.--': '!',
    '-..-.': '/',
    '-.--.': '(',
    '-.--.-': ')',
    '.-...': '&',
    '---...': ':',
    '-.-.-.': ';',
    '-...-': '=',
    '-....-': '-',
    '..--.-': '_',
    '.-..-.': '"',
    '.--.-.': '@',
  };

  Future<void> share() async {
    await FlutterShare.share(title: 'share', text: res, chooserTitle: 'Share');
  }

  void decrypt(String s) {
    for (int i = 0; i < s.length; i++) {
      if (s[i] != " ") {
        n = n + s[i];
      } else {
        l.add(n);

        n = "";
      }
    }
    print(l);

    for (int i = 0; i < l.length; i++) {
      if (d.containsKey(l[i])) {
        dec = dec + d[l[i]] + " "; //dec=dec+d[l[i]]+" ";
      } else {
        continue;
      }
    }

    print(dec);
    setState(() {
      res = dec;
    });
  }

  void clear() {
    //this method is used to clean the enc field
    setState(() {
      res = "";
      dec = "";
      tc.text = "";
      l = [];
      n = "";
    });
  }

  void copy() {
    //this method is used to copy.
    FlutterClipboard.copy(res);
    FlutterClipboard.paste().then((value) {
      res = value;
    });
  }

  void shareApp() {
    //this method is used to share the msg.
    share();
  }

  void show(String msg) {
    final snackBar = SnackBar(
      duration: Duration(milliseconds: 145),
      content: Text(msg),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 310.0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      "INPUT:",
                      style: TextStyle(
                          color: widget.theme == "light"
                              ? Colors.white
                              : Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200.0,
                    color:
                        widget.theme == "light" ? Colors.white : Colors.black,
                    child: TextField(
                        controller: tc,
                        style: TextStyle(
                          color: widget.theme == "light"
                              ? Colors.black
                              : Colors.white,
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 10,
                        cursorColor: widget.theme == "light"
                            ? Colors.black
                            : Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: widget.theme == "light"
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(1, 1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(1, 1)),
                            borderSide: BorderSide(
                              color: widget.theme == "light"
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          hintText: 'Enter a Morse code here',
                          hintStyle: TextStyle(
                              color: widget.theme == "light"
                                  ? Colors.black
                                  : Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 120.0,
                    height: 45.0,
                    color:
                        widget.theme == "light" ? Colors.white : Colors.black,
                    child: RaisedButton(
                      color:
                          widget.theme == "light" ? Colors.white : Colors.black,
                      elevation: 20.0,
                      child: Text(
                        'Decrypt',
                        style: TextStyle(
                          color: widget.theme == "light"
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        decrypt(tc.text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: widget.theme == "light" ? Colors.white : Colors.black,
            height: 2.0,
            thickness: 1.0,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 310.0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      "OUTPUT:",
                      style: TextStyle(
                          color: widget.theme == "light"
                              ? Colors.white
                              : Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200.0,
                    color:
                        widget.theme == "light" ? Colors.white : Colors.black,
                    child: Text(
                      res,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: widget.theme == "light"
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            color: widget.theme == "light"
                                ? Colors.white
                                : Colors.black,
                            elevation: 20.0,
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                color: widget.theme == "light"
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              clear();
                              show('The Input and output are cleared!');
                            },
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          RaisedButton(
                            color: widget.theme == "light"
                                ? Colors.white
                                : Colors.black,
                            elevation: 20.0,
                            child: Text(
                              'Copy',
                              style: TextStyle(
                                color: widget.theme == "light"
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              copy();
                              show('The Output is Copied!');
                            },
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          RaisedButton(
                            color: widget.theme == "light"
                                ? Colors.white
                                : Colors.black,
                            elevation: 20.0,
                            child: Text(
                              'Share',
                              style: TextStyle(
                                color: widget.theme == "light"
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              shareApp();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
