import 'package:flutter/material.dart';
import 'package:cards/core/presentation/page/consts.dart';
import 'package:cards/core/data/round.json';
import 'package:json_annotation/json_annotation.dart';

part 'textSpeech.g.dart';

@JsonSerializable()
class textSpeech {
  final String ask, result, NPC;
  final int id;

  textSpeech({required this.ask, required this.result, required this.id, required this.NPC});

  factory textSpeech.fromJson(Map<String, dynamic> json) => _$textSpeechFromJson(json);
  Map<String, dynamic> toJson() => _$textSpeechToJson(this);
  void printValues() {
    print(_$textSpeechFromJson('lib/core/data/round.json' as Map<String, dynamic>));
  }
}

textSpeech _$textSpeechFromJson(Map<String, dynamic> json) => textSpeech (
  id: json['id'] as int,
  ask: json['ask'] as String,
  result: json['result'] as String,
  NPC: json['NPC'] as String,
);

Map<String, dynamic> _$textSpeechToJson(textSpeech instance) => <String, dynamic>{
  'id': instance.id,
  'ask': instance.ask,
  'result': instance.result,
  'NPC': instance.NPC,
};