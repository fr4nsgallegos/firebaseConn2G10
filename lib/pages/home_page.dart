import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2/models/user_model.dart';
import 'package:firebaseconn2/pages/future_list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conexión a firestore"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                usersReference.get().then((value) {
                  print(value);
                  QuerySnapshot userCollection = value;
                  List<QueryDocumentSnapshot> docs = userCollection.docs;
                  // print(docs);
                  // docs.forEach((element) {
                  //   print(element.data());
                  // });

                  //Usando el modelo User en lugar del map directo
                  List<UserModel> users = docs.map((doc) {
                    return UserModel.fromMap(
                        doc.data() as Map<String, dynamic>, doc.id);
                  }).toList();

                  users.forEach((user) {
                    print(user.id);
                    print(user.name);
                    print(user.lastname);
                    print(user.age);
                    print("-....................-");
                  });
                });
              },
              child: Text("Get data"),
            ),
            ElevatedButton(
              onPressed: () {
                usersReference
                    .where("name", isEqualTo: "Jhonny")
                    .where("age", isGreaterThan: 10)
                    .get()
                    .then((value) {
                  print(value);
                  QuerySnapshot userCollection = value;
                  List<QueryDocumentSnapshot> docs = userCollection.docs;
                  print(docs);
                  docs.forEach((element) {
                    print(element.data());
                  });
                });
              },
              child: Text("Get data filtrada"),
            ),
            ElevatedButton(
              onPressed: () {
                // usersReference.add({
                //   "name": "Julio",
                //   "lastname": "Mar",
                //   "age": 35,
                //   "weigth": 80,
                // }).then((value) {
                //   print(value);
                //   print(value.id);
                // });

                UserModel newUser = UserModel(
                  id: '',
                  name: "Julio",
                  lastname: "Martinez",
                  age: 35,
                  heigth: 58,
                  weight: 52,
                );

                //usamos el metodo tomap para convertir el objeto en un mapa
                usersReference.add(newUser.toMap()).then(
                  (value) {
                    print("Nuevo usuario agregado con el id ${value.id}");
                  },
                );
              },
              child: Text("Agregar usuario"),
            ),
            ElevatedButton(
              onPressed: () {
                usersReference.doc("id1").set(
                  {
                    "name": "Maria",
                    "lastname": "Pacheco",
                    "age": 58,
                    "weigth": 75,
                  },
                );
              },
              child: Text("inserción con id"),
            ),
            ElevatedButton(
              onPressed: () {
                usersReference.doc("id1").update({
                  "heigth": 1.78,
                });
              },
              child: Text("Actualización"),
            ),
            ElevatedButton(
              onPressed: () {
                usersReference.doc("id1").delete();
              },
              child: Text("Eliminar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureListPage(),
                  ),
                );
              },
              child: Text("Future list "),
            ),
          ],
        ),
      ),
    );
  }
}
