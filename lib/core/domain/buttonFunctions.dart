import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:developer';

void closeApp() {
  log("message");
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}

void mainMenu()
{
  log("menuOpen");

}
void continuePlaying(){
  log("continuePlaying");
}