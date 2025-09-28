import 'dart:math';
import 'package:cards/core/domain/round.dart';
import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cards/core/presentation/page/footer.dart';
import 'package:cards/core/presentation/page/SpeechBubble.dart';
import 'package:cards/core/presentation/page/KeyWordText.dart';

void main() {
  runApp(Cards());
}

class Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cards',
      home: GamePage(),
      theme: ThemeData(
        colorScheme: ColorScheme(brightness: Brightness.dark, primary: white, onPrimary: black, secondary: fialka, onSecondary: black, error: fialka, onError: black, surface: black, onSurface: white),
      ),
    );
  }
}

class GamePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
        toolbarHeight: 56,
        actionsPadding: EdgeInsets.only(right: appWidth - 64),
        actions: [
          SvgPicture.asset(
            'lib/utils/logo.svg',
            colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
            width: 48,
          ),
        ],
      ),
      body: Center(
        widthFactor: appWidth,
        heightFactor: appHeight - 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: max(appHeight - 380, 300),
              width: appWidth,
              alignment: Alignment.topCenter,
            ),
            Container(
              height: 200,
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(appWidth - 32, 200),
                    painter: SpeechBubble(),
                  ),
                  FutureBuilder(
                    future: loadJsonData(),
                    builder: (context, snapshot) {
                      if (!(snapshot.hasError || snapshot.connectionState == ConnectionState.waiting)) {
                        return KeyWordText(text: "${snapshot.data?['ask']}", keywordsstr: "${snapshot.data?['keywords']}");
                      } else {
                        return KeyWordText(text: "", keywordsstr: "");
                      }
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: fialka,
        child: Footer(),
      ),
      backgroundColor: black,
    );
  }
}
