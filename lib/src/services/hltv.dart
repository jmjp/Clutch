import 'package:clutch/src/models/gameEvents.dart';
import 'package:clutch/src/models/profilePlayer.dart';
import '../models/ranking.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String baseURL = "https://noscope.herokuapp.com/api/";

Future<List<Ranking>> playerRanking() async{
  final response = await http.get(baseURL+'playersranking');
  if(response.statusCode == 200){
    return rankingFromJson(response.body);
  }else{
    throw Exception("Data");
  }
}

Future<ProfilePlayer> getPlayerProfile(int id) async{
  final response = await http.get(baseURL+'player/'+id.toString());
  if(response.statusCode == 200){
    return ProfilePlayer.fromJson(json.decode(response.body));
  }else{
    throw Exception("Data");
  }
}

Future<List<GameEvents>> getGameEvents(int month) async{
  final response = await http.get(baseURL+'events/month/'+month.toString());
  if(response.statusCode == 200){
    return gameEventsFromJson(response.body);
  }else{
    throw Exception("Data");
  }
}