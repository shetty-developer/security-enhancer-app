import 'package:flutter/material.dart';
import 'package:security_enhancer/splash_screen.dart';

void main() => runApp(
      SecurityEnhancer(),
    );



class SecurityEnhancer extends StatefulWidget {
  @override
  _SecurityEnhancerState createState() => _SecurityEnhancerState();
}

class _SecurityEnhancerState extends State<SecurityEnhancer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),      
    );
  }
}