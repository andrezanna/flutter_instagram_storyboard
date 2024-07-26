import 'package:flutter/material.dart';

class Story {
  bool like;
  String text;
  Widget body;
  Widget? userWidget;


  Story({required this.like,required this.text, required this.body, this.userWidget});


}
