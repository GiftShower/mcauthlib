// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mojangtypes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agent _$AgentFromJson(Map<String, dynamic> json) => Agent()
  ..name = json['name'] as String
  ..version = json['version'] as int;

Map<String, dynamic> _$AgentToJson(Agent instance) => <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
    };

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      json['username'] as String,
      json['password'] as String,
    )
      ..agent = Agent.fromJson(json['agent'] as Map<String, dynamic>)
      ..clientToken = json['clientToken'] as String
      ..requestUser = json['requestUser'] as bool;

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'agent': instance.agent.toJson(),
      'username': instance.username,
      'password': instance.password,
      'clientToken': instance.clientToken,
      'requestUser': instance.requestUser,
    };
