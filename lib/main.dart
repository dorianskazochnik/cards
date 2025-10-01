import 'dart:io' show Platform;
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
import 'package:flutter/services.dart';
import 'dart:developer';


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

  // для переключений между текстами
  bool textChanged = false;
  // правильный ли выбран результат
  bool result = false;
  // правильные ли выбраны слова
  bool resWords = false;
  // сеты выбранных слов и нужных слов
  Set<String> selectedWords = {};
  Set<String> correctWords = {};
  // маркер окончания хода
  bool answered = false;

  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;
    MediaQuery.of(context).removePadding();
    MediaQuery.of(context).removeViewInsets();
    MediaQuery.of(context).removeViewPadding();
    double margin = 16;
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
          // тут происходит показ и начисление орехов (поинтов)
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                return Text('');
              }
              // если нет ошибок в передаче типов, мы показываем поинты
              else if (snapshot.hasData && snapshot.data != null) {
                var data = snapshot.data;
                int points = data?['userPoints'] ?? 0;
                // если ход завершен -> плюс 200 поинтов и запись в память.
                if (answered) {
                  points += 200;
                  Map<String, dynamic> p = Map<String, dynamic>();
                  p['userPoints'] = points;
                  saveJsonDataPoints(p);
                }
                // если ход не завершен -> просто показываем поинты
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
          alignment: Alignment.bottomCenter,
          children: [
            // белое окошко для текста и кнопки
            Positioned (
              bottom: 10,
              child: CustomPaint(
                size: Size(appWidth - 32, 300),
                painter: SpeechBubble(),
              ),
            ),
            // если ход не завершен -> показываем персонажа (в данном случае котика)
            if (!answered) Positioned(
              bottom: 250,
              child: Image.asset(
                'lib/utils/cat.png',
                colorBlendMode: BlendMode.dst,
                width: appWidth - 80,
              ),
            )
            // а если завершен -> начисление поинтов в виде строки
            else Positioned(
              bottom: 350,
              child: Text(
                '+200 орехов',
                style: TextStyle(
                  color: fialka,
                  fontSize: sizeheader,
                  fontFamily: "Halvar",
                ),
              )
            ),
            // здесь код диалогового окна с выбором продукта из трёх
            Positioned (
                bottom: 252,
                right: margin * 1.5,
                child : FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                      return Text('');
                    }
                    // если нет ошибок в передаче типов показываем кнопку
                    else if (snapshot.hasData && snapshot.data != null && !answered) {
                      List<String> results = List<String>.from(snapshot.data?['wrongResult'] ?? []);
                      String correctresult = snapshot.data?['result'] ?? "";
                      results.add(correctresult);
                      return MaterialButton(
                        // при нажатии если мы выбрали верные слова -> показывается диалоговое окно выбора из трёх продуктов.
                        // иначе просто обновляются данные и меняется текст поля
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
            // здесь код слов и вывода ответов персонажа
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
                  // если нет ошибок, показывается ответ и раунд продолжается -> показываем ответы персонажа в зависимости от правильности выборов.
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
                  // если нет ошибок, показываются слова персонажа и раунд продолжается -> показываем слова персонажа,
                  // подсвечивая выбранные.
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
                    // передаем выбранные слова
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
        child: Footer(margin: margin),
      ),
      backgroundColor: black,
    );
  }
}
