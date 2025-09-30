import 'dart:io';
import 'package:flutter/services.dart';


void closeAppUsingSystemPop() {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}

void mainMenu()
{

}
void continuePlaying(){}