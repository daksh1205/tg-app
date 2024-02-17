import 'package:flutter/material.dart';
import 'package:tg_app/view/discovery_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiscoveryPage(),
    );
  }
}
