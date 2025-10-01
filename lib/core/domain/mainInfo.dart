import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadJsonDataPoints() async {
  final String response = await rootBundle.loadString('lib/core/data/mainInfo.json');
  final Map<String, dynamic> data = json.decode(response);
  return data;
}

Future<void> saveJsonDataPoints(Map<String, dynamic> jsonData) async {
  final file = File('lib/core/data/mainInfo.json');
  await file.writeAsString(json.encode(jsonData));
}