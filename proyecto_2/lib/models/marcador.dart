import 'dart:convert';


/// Clase marcador:
/// Esta clase se usa para crear objetos de tipo marcador con la información proporcionada por los usuarios. Estos objetos son
/// los que despues aparecen en las tarjetas de la página principal de la aplicación.

class Marcador {

    // Constructor
    Marcador({
        required this.adress,
        required this.creatorId,
        required this.description,
        required this.name,
        this.picture,
        this.position,
        this.id,
    });

    // Atributos
    String adress;
    String creatorId;
    String description;
    String name;
    String? picture;
    String? position;
    String? id;


    factory Marcador.fromJson(String str) => Marcador.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    // Esta funcioón se emplea para crear objetos de tipo Marcador a partir de de un Map<String, dynamic>
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
