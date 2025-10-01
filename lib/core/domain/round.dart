import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadJsonDataRound() async {
  final String response = await rootBundle.loadString('lib/core/data/round.json');
  final Map<String, dynamic> data = json.decode(response);
  return data;
}

Future<void> saveJsonDataRound(Map<String, dynamic> jsonData) async {
  final file = File('lib/core/data/round.json');
  await file.writeAsString(json.encode(jsonData));
}