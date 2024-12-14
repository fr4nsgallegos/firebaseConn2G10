import 'package:cloud_firestore/cloud_firestore.dart';
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
                  print(docs);
                  docs.forEach((element) {
                    print(element.data());
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
                usersReference.add({
                  "name": "Julio",
                  "lastname": "Mar",
                  "age": 35,
                  "weigth": 80,
                }).then((value) {
                  print(value);
                  print(value.id);
                });
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
          ],
        ),
      ),
    );
  }
}
