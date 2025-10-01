import 'package:flutter/foundation.dart';

// метод сравнения результатов по ключевым словам
bool wordsChoice(Set<String> keywords, Set<String> userWords)
{
  return setEquals(keywords, userWords);

}

// метод сравнения результатов выбора продуктов (из 3)
bool isResultCorrect(String expectedResult, String userResult)
{
  return userResult == expectedResult;

}