import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:clipboard/clipboard.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';

class Encryption extends StatefulWidget {
  final String theme;
  Encryption({this.theme});
  @override
  _EncryptionState createState() => _EncryptionState();
}

class _EncryptionState extends State<Encryption> {
  String enc = "";
  String res = "";
  String u;
  final tc = TextEditingController();
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Start Speaking....";
  bool micpressed = false;

  var d = {
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '0': '-----',
    '.': '.-.-.-',
    ',': '--..--',
    '?': '..--..',
    '‘': '.----.',
    '!': '.-.--',
    '/': '-..-.',
    '(': '-.--.',
    ')': '-.--.-',
    '&': '.-...',
    ':': '---...',
    ';': '-.-.-.',
    '=': '-...-',
    '-': '-....-',
    '_': '..--.-',
    '"': '.-..-.',
    '@': '.--.-.',
  };

  Future<void> share() async {
    await FlutterShare.share(title: 'share', text: res, chooserTitle: 'Share');
  }

  void encrypt(String s) {
    u = s.toUpperCase();
    for (int i = 0; i < u.length; i++) {
      if (d.containsKey(u[i])) {
        enc = enc + d[u[i]] + " ";
      } else {
        continue;
      }
    }
    setState(() {
      res = enc;
    });
  }

  void clear() {
    //this method is used to clean the enc field
    setState(() {
      res = "";
      enc = "";
      tc.text = "";
      _text = "";
      micpressed = false;
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
      content: Text(msg),
      duration: Duration(milliseconds: 145),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _listen() async {
    micpressed = true;
    if (!_isListening) {
      bool available = await _speech.initialize(onStatus: (val) {
        print("onStatus:$val");
      }, onError: (val) {
        print("onError: $val");
      });
      if (available) {
        setState(() {
          _isListening = true;
          _speech.listen(onResult: (val) {
            setState(() {
              _text = val.recognizedWords;
            });
          });
        });
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
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
                      'INPUT:',
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
                  micpressed == true
                      ? Container(
                          width: double.infinity,
                          height: 200.0,
                          color: widget.theme == "light"
                              ? Colors.white
                              : Colors.black,
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 30.0, 30.0,30.0),
                          child: Text(
                            _text,
                            style: TextStyle(
                              color: widget.theme == "light"
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 200.0,
                          color: widget.theme == "light"
                              ? Colors.white
                              : Colors.black,
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
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isListening ? Icons.mic : Icons.mic_none,
                                    color: widget.theme == "light"
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  onPressed: () {
                                    _listen();
                                  },
                                ),
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
                                hintText: 'Enter a text here',
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
                    child: RaisedButton(
                      color:
                          widget.theme == "light" ? Colors.white : Colors.black,
                      elevation: 20.0,
                      child: Text(
                        'Encrypt',
                        style: TextStyle(
                          color: widget.theme == "light"
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        micpressed == true ? encrypt(_text) : encrypt(tc.text);
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
                              show('The Input and Output are cleared!');
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
                              show('The Output is copied!');
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
                              share();
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
