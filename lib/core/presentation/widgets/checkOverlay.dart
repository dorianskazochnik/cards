import 'package:cards/core/domain/userChoices.dart';
import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';

//класс диалогового окна с выбором из трёх продуктов
class CheckOverlay extends StatelessWidget {
  final double width, height;
  final List<String> results;
  CheckOverlay({required this.width, required this.height, required this.results});

  late int selected;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: Colors.black.withValues(alpha: 0.5),
          ),
          Center(
            child: Container(
              width: width - 32,
              height: 300,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        selected = 0;
                        Navigator.of(context).pop(results[selected]);
                      },
                      child: Text(
                        results[0],
                        style: TextStyle(
                          color: black,
                          fontSize: sizetext,
                          fontFamily: "Halvar",
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: () {
                        selected = 1;
                        Navigator.of(context).pop(results[selected]);
                      },
                      child: Text(
                        results[1],
                        style: TextStyle(
                          color: black,
                          fontSize: sizetext,
                          fontFamily: "Halvar",
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: () {
                        selected = 2;
                        Navigator.of(context).pop(results[selected]);
                      },
                      child: Text(
                        results[2],
                        style: TextStyle(
                          color: black,
                          fontSize: sizetext,
                          fontFamily: "Halvar",
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}