// To parse this JSON data, do
//
//     final ranking = rankingFromJson(jsonString);

import 'dart:convert';

List<Ranking> rankingFromJson(String str) => new List<Ranking>.from(json.decode(str).map((x) => Ranking.fromJson(x)));

String rankingToJson(List<Ranking> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Ranking {
    int id;
    String name;
    double rating;

    Ranking({
        this.id,
        this.name,
        this.rating,
    });

    factory Ranking.fromJson(Map<String, dynamic> json) => new Ranking(
        id: json["id"],
        name: json["name"],
        rating: json["rating"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rating": rating,
    };
}
