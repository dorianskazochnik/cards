import 'package:flutter/foundation.dart';

bool wordsChoice(Set<String> keywords, Set<String> userWords)
{
  return setEquals(keywords, userWords);

}

bool isResultCorrect(String userResult, String expectedResult) //первое ввод юзера, второе значение из json
{
  return userResult==expectedResult;

}