import 'package:flutter/material.dart';

extension SpaceBetween on List<Widget>{
  List<Widget> withSpaceBetween({double width = 0, double height = 0}){
    List<Widget> result = [];
    for(int i = 0; i < length; i++){
      result.add(this[i]);
      if(i < length - 1){
        result.add(SizedBox(width: width, height: height,));
      }
    }
    return result;
  }
}