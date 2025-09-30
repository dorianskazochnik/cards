import 'package:flutter/foundation.dart';

bool wordsChoice(List<String> keywords, List<String> userWords)
{
  return listEquals(keywords, userWords);

}

bool isResultCorrect(String userResult, String expectedResult) //первое ввод юзера, второе значение из json
{
  return userResult==expectedResult;

}