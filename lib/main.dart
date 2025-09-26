import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cards/core/presentation/page/footer.dart';
import 'package:cards/core/presentation/page/SpeechBubble.dart';

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
        textTheme: TextTheme(bodyLarge: TextStyle(color: white, fontSize: sizetext, fontFamily: "Gazprombank-Sans"),
            titleLarge: TextStyle(color: white, fontSize: sizeheader, fontFamily: "Halvar")),
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
            height: 32.5,
            width: 48,
          ),
        ],
      ),
      body: Center(
        widthFactor: appWidth,
        heightFactor: appHeight - 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: appWidth,
              width: appWidth,
              alignment: Alignment.topCenter,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomPaint(
                  size: Size(appWidth - 32, 200),
                  painter: SpeechBubble(),
                ),
              ],
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