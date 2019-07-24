// To parse this JSON data, do
//
//     final profilePlayer = profilePlayerFromJson(jsonString);

import 'dart:convert';

ProfilePlayer profilePlayerFromJson(String str) => ProfilePlayer.fromJson(json.decode(str));

String profilePlayerToJson(ProfilePlayer data) => json.encode(data.toJson());

class ProfilePlayer {
    String id;
    String name;
    String ign;
    String image;
    int age;
    String twitter;
    String twitch;
    String facebook;
    Country country;
    Team team;
    Statistics statistics;
    List<Achievement> achievements;

    ProfilePlayer({
        this.id,
        this.name,
        this.ign,
        this.image,
        this.age,
        this.twitter,
        this.twitch,
        this.facebook,
        this.country,
        this.team,
        this.statistics,
        this.achievements,
    });

    factory ProfilePlayer.fromJson(Map<String, dynamic> json) => new ProfilePlayer(
        id: json["id"],
        name: json["name"],
        ign: json["ign"],
        image: json["image"],
        age: json["age"],
        twitter: json["twitter"],
        twitch: json["twitch"],
        facebook: json["facebook"],
        country: Country.fromJson(json["country"]),
        team: Team.fromJson(json["team"]),
        statistics: Statistics.fromJson(json["statistics"]),
        achievements: new List<Achievement>.from(json["achievements"].map((x) => Achievement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ign": ign,
        "image": image,
        "age": age,
        "twitter": twitter,
        "twitch": twitch,
        "facebook": facebook,
        "country": country.toJson(),
        "team": team.toJson(),
        "statistics": statistics.toJson(),
        "achievements": new List<dynamic>.from(achievements.map((x) => x.toJson())),
    };
}

class Achievement {
    Place place;
    Team event;

    Achievement({
        this.place,
        this.event,
    });

    factory Achievement.fromJson(Map<String, dynamic> json) => new Achievement(
        place: placeValues.map[json["place"]],
        event: Team.fromJson(json["event"]),
    );

    Map<String, dynamic> toJson() => {
        "place": placeValues.reverse[place],
        "event": event.toJson(),
    };
}

class Team {
    String name;
    int id;

    Team({
        this.name,
        this.id,
    });
    factory Team.fromJson(Map<String, dynamic> json) => new Team(
        name: json == null ? "None" : json["name"],
        id: json == null ? 0000 : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
    };
}

enum Place { THE_3_RD, THE_2_ND, GROUP_STAGE, THE_14_FINAL, THE_1_ST }

final placeValues = new EnumValues({
    "Group stage": Place.GROUP_STAGE,
    "1/4 final": Place.THE_14_FINAL,
    "1st": Place.THE_1_ST,
    "2nd": Place.THE_2_ND,
    "3rd": Place.THE_3_RD
});

class Country {
    String name;
    String code;

    Country({
        this.name,
        this.code,
    });

    factory Country.fromJson(Map<String, dynamic> json) => new Country(
        name: json["name"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
    };
}

class Statistics {
    double rating;
    double killsPerRound;
    double headshots;
    int mapsPlayed;
    double deathsPerRound;
    double roundsContributed;

    Statistics({
        this.rating,
        this.killsPerRound,
        this.headshots,
        this.mapsPlayed,
        this.deathsPerRound,
        this.roundsContributed,
    });

    factory Statistics.fromJson(Map<String, dynamic> json) => new Statistics(
        rating: json["rating"].toDouble(),
        killsPerRound: json["killsPerRound"].toDouble(),
        headshots: json["headshots"].toDouble(),
        mapsPlayed: json["mapsPlayed"],
        deathsPerRound: json["deathsPerRound"].toDouble(),
        roundsContributed: json["roundsContributed"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "killsPerRound": killsPerRound,
        "headshots": headshots,
        "mapsPlayed": mapsPlayed,
        "deathsPerRound": deathsPerRound,
        "roundsContributed": roundsContributed,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
