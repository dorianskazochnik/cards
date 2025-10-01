import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadJsonData() async {
  final String response = await rootBundle.loadString('lib/core/data/mainInfo.json');
  final Map<String, dynamic> data = json.decode(response);
  return data;
}

