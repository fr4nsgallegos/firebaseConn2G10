import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamFirestorePage extends StatelessWidget {
  //REFERENCIA A LA COLECCION EN FIRESTORE
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userCollection.add({
            "name": "Pedro",
            "lastname": "Suarez",
            "age": 80,
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("STREAM FIRESTORE PAGE"),
      ),
      body: Center(
        child: Center(
          child: StreamBuilder(
            stream: userCollection.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text("ERROR: ${snapshot.error}");
              }

              List<QueryDocumentSnapshot> docs = snapshot.data.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = docs[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data["name"]),
                    subtitle: Text("edad: ${data["age"].toString()}"),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
