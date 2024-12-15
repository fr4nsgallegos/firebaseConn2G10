import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FutureListPage extends StatelessWidget {
  CollectionReference userReference =
      FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future List"),
      ),
      body: Center(
        child: FutureBuilder(
          future: userReference.get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("------------------------------");
            print("snapshot: $snapshot");
            print("connectionState: ${snapshot.connectionState}");
            print("data:  ${snapshot.data}");
            print("------------------------------");
            if (snapshot.hasData) {
              QuerySnapshot userCollection = snapshot.data;
              List<QueryDocumentSnapshot> docs = userCollection.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(docs[index]["name"]),
                    subtitle: Text(docs[index]["lastname"]),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}