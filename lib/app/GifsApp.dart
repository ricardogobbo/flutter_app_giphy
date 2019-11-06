import 'package:app_5_gifs/app/views/GifView.dart';
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