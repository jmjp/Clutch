// To parse this JSON data, do
//
//     final gameEvents = gameEventsFromJson(jsonString);

import 'dart:convert';

List<GameEvents> gameEventsFromJson(String str) => new List<GameEvents>.from(json.decode(str).map((x) => GameEvents.fromJson(x)));

String gameEventsToJson(List<GameEvents> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class GameEvents {
    int month;
    List<Event> events;

    GameEvents({
        this.month,
        this.events,
    });

    factory GameEvents.fromJson(Map<String, dynamic> json) => new GameEvents(
        month: json["month"],
        events: new List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "month": month,
        "events": new List<dynamic>.from(events.map((x) => x.toJson())),
    };
}

class Event {
    int id;
    String name;
    int dateStart;
    int dateEnd;
    String prizePool;
    int teams;
    String location;
    Type type;

    Event({
        this.id,
        this.name,
        this.dateStart,
        this.dateEnd,
        this.prizePool,
        this.teams,
        this.location,
        this.type,
    });

    factory Event.fromJson(Map<String, dynamic> json) => new Event(
        id: json["id"],
        name: json["name"],
        dateStart: json["dateStart"],
        dateEnd: json["dateEnd"] == null ? null : json["dateEnd"],
        prizePool: json["prizePool"],
        teams: json["teams"] == null ? null : json["teams"],
        location: json["location"] == null ? null : json["location"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dateStart": dateStart,
        "dateEnd": dateEnd == null ? null : dateEnd,
        "prizePool": prizePool,
        "teams": teams == null ? null : teams,
        "location": location == null ? null : location,
        "type": type == null ? null : typeValues.reverse[type],
    };
}

enum Type { MAJOR, REG_LAN, LOCAL_LAN, INTL_LAN, ONLINE }

final typeValues = new EnumValues({
    "Intl. LAN": Type.INTL_LAN,
    "Local LAN": Type.LOCAL_LAN,
    "Major": Type.MAJOR,
    "Online": Type.ONLINE,
    "Reg. LAN": Type.REG_LAN
});

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
