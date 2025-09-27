// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'textSpeech.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

textSpeech _$textSpeechFromJson(Map<String, dynamic> json) => textSpeech(
  ask: json['ask'] as String,
  result: json['result'] as String,
  id: (json['id'] as num).toInt(),
  NPC: json['NPC'] as String,
);

Map<String, dynamic> _$textSpeechToJson(textSpeech instance) =>
    <String, dynamic>{
      'ask': instance.ask,
      'result': instance.result,
      'NPC': instance.NPC,
      'id': instance.id,
    };
