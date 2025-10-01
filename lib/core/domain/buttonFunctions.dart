import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:developer';

// функционал кнопок меню. контроль исполнения логами.

// закрыть (крестик справа)
void closeApp() {
  log("message");
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}

// открыть меню (центральное)
void mainMenu()
{
  log("menuOpen");

}

// продолжать игру (стрелочка слева)
void continuePlaying(){
  log("continuePlaying");
}