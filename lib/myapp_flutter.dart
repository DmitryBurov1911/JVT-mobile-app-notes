// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:myapp/screens/homescreen.dart';


class FirstClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}