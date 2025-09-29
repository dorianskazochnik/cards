import 'dart:ui';
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
  Future<Map<String, dynamic>?> getData() async {
    return await loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    final outputState = context.findAncestorStateOfType<KeyWordTextState>();
    Set<String> output = {};
    if (outputState != null) {
      output = outputState.getSelectedKeywords();
    }
    Set<String> getOutput() {
      return output;
    }

    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
        toolbarHeight: 56,
        actionsPadding: EdgeInsets.only(right: (appWidth * 3 + 64) / 4),
        actions: [
          SvgPicture.asset(
            'lib/utils/logo.svg',
            colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
            width: (appWidth - 80) / 4,
          ),
        ],
      ),
      body: Container(
        width: appWidth,
        height: appHeight - 160,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned (
              left: 16,
              bottom: 10,
              child: CustomPaint(
                size: Size(appWidth - 32, 200),
                painter: SpeechBubble(),
              ),
            ),
            Positioned(
              bottom: 150,
              child: Image.asset(
                'lib/utils/cat.png',
                colorBlendMode: BlendMode.dst,
                width: appWidth - 80,
              ),
            ),
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                  return KeyWordText(
                    text: [],
                    keywordsstr: [],
                    width: appWidth - 32,
                    height: 200,);
                }
                else if (snapshot.hasData && snapshot.data != null) {
                  var data = snapshot.data;
                  return KeyWordText(
                    text: List<String>.from(data?['ask']?? []),
                    keywordsstr: List<String>.from(data?['keywords'] ?? []),
                    width: appWidth - 32,
                    height: 200
                  );
                }
                else {
                  return KeyWordText(
                    text: [],
                    keywordsstr: [],
                    width: appWidth - 32,
                    height: 200,);
                }
              },
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
