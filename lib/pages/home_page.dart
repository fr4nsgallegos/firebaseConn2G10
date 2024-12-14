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
                usersReference
                    .where("isPeruvian", isEqualTo: true)
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
              child: Text("Get data"),
            )
          ],
        ),
      ),
    );
  }
}
