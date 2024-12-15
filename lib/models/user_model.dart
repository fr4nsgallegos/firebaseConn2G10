class UserModel {
  String id;
  String name;
  String lastname;
  int age;
  double? weight;
  double? heigth;

  UserModel(
      {required this.id,
      required this.name,
      required this.lastname,
      required this.age,
      required this.heigth,
      required this.weight});

  //PARA TRANSFORMAR UN MAPA DE FIRESTORE A UN OBJETO USERMODEL
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map["name"],
      lastname: map["lastname"],
      age: map["age"],
      heigth: map["heigth"],
      weight: map["weight"],
    );
  }

  //CONVERTIR UN OBJETO USERMODEL EN UN MAPA DE FIRESTORE
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "lastname": lastname,
      "age": age,
      "weight": weight,
      "heigth": heigth,
    };
  }
}
