import 'package:flutter/material.dart';
import 'views/HomeView.dart';

class GifsApp {

  Widget build(){
    return MaterialApp(
      home: HomeView(),
      theme: ThemeData(
        hintColor: Colors.white,
      ),
    );
  }

}