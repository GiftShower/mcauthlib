import 'package:json_annotation/json_annotation.dart';

part 'mojangtypes.g.dart';

@JsonSerializable(explicitToJson: true)
class Agent {
  String name = "Minecraft";
  int version = 1;

  Agent();
  factory Agent.fromJson(Map<String, dynamic> json) => _$AgentFromJson(json);
  Map<String, dynamic> toJson() => _$AgentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Auth {
  Agent agent = Agent();
  String username;
  String password;
  String clientToken = "";
  bool requestUser = false;

  Auth(this.username, this.password);

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

class User {
  String username;
  String password="";
  String clientToken="";
  String accessToken="";

  User(this.username);
  User.authType(this.username, this.password);
  User.refreshType(this.username, this.clientToken, this.accessToken);
}