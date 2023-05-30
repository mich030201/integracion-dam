// To parse this JSON data, do
//
//     final marker = markerFromMap(jsonString);

// import 'dart:convert';

// class Marcador {

//     Marcador({
//         required this.creatorId,
//         this.description,
//         required this.latitude,
//         required this.longitude,
//         required this.name,
//         this.picture,
//         this.id,
//     });

//     String creatorId;
//     String? description;
//     String latitude;
//     String longitude;
//     String name;
//     String? picture;
//     String? id;

//     factory Marcador.fromJson(String str) => Marcador.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory Marcador.fromMap(Map<String, dynamic> json) => Marcador(
//         creatorId: json["creatorID"],
//         description: json["description"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         name: json["name"],
//         picture: json["picture"],
//     );

//     Map<String, dynamic> toMap() => {
//         "creatorID": creatorId,
//         "description": description,
//         "latitude": latitude,
//         "longitude": longitude,
//         "name": name,
//         "picture": picture,
//     };

//     Marcador copy() => Marcador(
//       creatorId: this.creatorId, 
//       latitude: this.latitude, 
//       longitude: this.longitude, 
//       name: this.name,
//       id: this.id
//     );
// }

// To parse this JSON data, do
//
//     final marker = markerFromMap(jsonString);

import 'dart:convert';

class Marcador {

    Marcador({
        required this.adress,
        required this.creatorId,
        required this.description,
        required this.name,
        this.picture,
        this.position,
        this.id,
    });

    String adress;
    String creatorId;
    String description;
    String name;
    String? picture;
    String? position;
    String? id;


    factory Marcador.fromJson(String str) => Marcador.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Marcador.fromMap(Map<String, dynamic> json) => Marcador(
        adress: json["adress"],
        creatorId: json["creatorID"],
        description: json["description"],
        name: json["name"],
        picture: json["picture"],
        position: json["position"],
    );

    Map<String, dynamic> toMap() => {
        "adress": adress,
        "creatorID": creatorId,
        "description": description,
        "name": name,
        "picture": picture,
        "position": position,
    };

    Marcador copy() => Marcador(
      name: this.name,
      adress: this.adress,
      creatorId: this.creatorId, 
      description: this.description,
      id: this.id
    );
}
