import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeChanger extends Cubit<ThemeMode>{
  ThemeChanger():super(ThemeMode.system);

  ThemeMode mode=ThemeMode.system;
  
  void setThemeMode(ThemeMode mode){
    this.mode=mode;
    emit(mode);
  }
  
  void getTheme(){
    emit(this.mode);
  }

}