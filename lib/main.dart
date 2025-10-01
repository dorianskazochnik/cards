import 'dart:ui';
import 'package:cards/core/domain/mainInfo.dart';
import 'package:cards/core/domain/round.dart';
import 'package:cards/core/domain/userChoices.dart';
import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cards/core/presentation/page/footer.dart';
import 'package:cards/core/presentation/page/SpeechBubble.dart';
import 'package:cards/core/presentation/page/KeyWordText.dart';
import 'package:cards/core/presentation/widgets/checkOverlay.dart';

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

class GamePage extends StatefulWidget {
  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  Future<Map<String, dynamic>?> getData() async {
    return await loadJsonDataRound();
  }

  Future<Map<String, dynamic>?> getPoints() async {
    return await loadJsonDataPoints();
  }

  bool textChanged = false;
  bool result = false;
  bool resWords = false;
  Set<String> selectedWords = {};
  Set<String> correctWords = {};
  bool answered = false;

  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
        toolbarHeight: 56,
        actionsPadding: EdgeInsets.only(right: (appWidth * 3 + 64) / 4 - sizeheader * 3),
        actions: [
          SvgPicture.asset(
            'lib/utils/logo.svg',
            colorFilter: ColorFilter.mode(white, BlendMode.srcIn),
            width: (appWidth - 80) / 4,
          ),
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                return Text('');
              }
              else if (snapshot.hasData && snapshot.data != null) {
                var data = snapshot.data;
                int points = data?['userPoints'] ?? 0;
                if (answered) {
                  points += 200;
                  Map<String, dynamic> p = Map<String, dynamic>();
                  p['userPoints'] = points;
                  saveJsonDataPoints(p);
                }
                return Text(
                  points.toString(),
                  style: TextStyle(
                    color: fialka,
                    fontSize: sizeheader,
                    fontFamily: "Halvar",
                  ),
                );
              } else {
                return Text('');
              }
            },
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
                size: Size(appWidth - 32, 300),
                painter: SpeechBubble(),
              ),
            ),
            if (!answered) Positioned(
              bottom: 250,
              child: Image.asset(
                'lib/utils/cat.png',
                colorBlendMode: BlendMode.dst,
                width: appWidth - 80,
              ),
            )
            else Positioned(
              bottom: 250,
              child: Text(
                '+200 орехов',
                style: TextStyle(
                  color: fialka,
                  fontSize: sizeheader,
                  fontFamily: "Halvar",
                ),
              )
            ),
            Positioned (
                bottom: 252,
                right: 24,
                child : FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                      return Text('');
                    }
                    else if (snapshot.hasData && snapshot.data != null && !answered) {
                      List<String> results = List<String>.from(snapshot.data?['wrongResult'] ?? []);
                      String correctresult = snapshot.data?['result'] ?? "";
                      results.add(correctresult);
                      return MaterialButton(
                        onPressed: () async {
                          setState(() {
                            textChanged = !textChanged;
                            resWords = wordsChoice(correctWords, selectedWords);
                          });
                          if (resWords) {
                            final String res = await showDialog(
                              context: context,
                              builder: (context) => CheckOverlay(width: appWidth + 32, height: appHeight + 32, results: results),
                            );
                            setState(() {
                              result = isResultCorrect(res, correctresult);
                              answered = true;
                            });
                          }
                        },
                        color: malina,
                        highlightColor: sakura,
                        shape: CircleBorder(),
                        height: 56,
                        minWidth: 56,
                      );
                    }
                    else {
                      return Text('');
                    }
                  }
                )
            ),
            Positioned(
              bottom: (textChanged)? -70 : 10,
              width: appWidth - 64,
              height: 270,
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                    return Text('');
                  }
                  else if (snapshot.hasData && snapshot.data != null && textChanged && !answered) {
                    var data = snapshot.data;
                    String wa = data?['wrongAnswer'] ?? "";
                    String ca = data?['correctAnswer'] ?? "";
                    return RichText(
                      text: TextSpan(
                        text: (result || resWords)? ca : wa,
                        style: TextStyle(
                          color: black,
                          fontSize: sizetext,
                          fontFamily: "Gazprombank-Sans",
                        ),
                      ),
                    );
                  }
                  else if (snapshot.hasData && snapshot.data != null && !answered) {
                    var data = snapshot.data;
                    correctWords = Set<String>.from(data?['keywords'] ?? []);
                    List<String> words = List<String>.from(data?['keywords'] ?? []);
                    words.addAll(List<String>.from(data?['wrongwords'] ?? []));
                    KeyWordText kwt = KeyWordText(
                        text: List<String>.from(data?['ask'] ?? []),
                        keywordsstr: words,
                        width: appWidth - 32,
                        height: 300
                    );
                    selectedWords = kwt.getSelectedKeywords();
                    return kwt;
                  }
                  else {
                    return Text('');
                  }
                }
              )
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
