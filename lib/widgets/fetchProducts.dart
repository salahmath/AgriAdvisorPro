// ignore_for_file: file_names, unnecessary_import, prefer_const_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_function_literals_in_foreach_calls, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_import

import 'package:app_commerce/paiement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  final String collectionName;

  MyWidget(this.collectionName);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  double total = 0.0; // Ajout de la variable pour le total

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(widget.collectionName)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("items")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Quelque chose ne va pas"),
          );
        }

        // Calculer le total en fonction de la quantité de chaque produit
        total = 0.0;
        if (snapshot.hasData) {
          snapshot.data!.docs.forEach((document) {
            double productPrice = document['price'];
            double productQuantity = document['quantite'];
            total += productPrice * productQuantity;
          });
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                  double productPrice = _documentSnapshot['price'];
                  double productQuantity = _documentSnapshot['quantite'];

                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Text(_documentSnapshot['name']),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$ ${(productPrice * productQuantity).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                child: CircleAvatar(
                                  child: Icon(EvaIcons.fileRemoveOutline),
                                ),
                                onTap: () async {
                                  if (productQuantity > 1) {
                                    productQuantity--;
                                    await FirebaseFirestore.instance
                                        .collection(widget.collectionName)
                                        .doc(FirebaseAuth.instance.currentUser!.email)
                                        .collection("items")
                                        .doc(_documentSnapshot.id)
                                        .update({'quantite': productQuantity});
                                    setState(() {});
                                  }
                                },
                              ),
                              Text(
                                productQuantity.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                child: CircleAvatar(
                                  child: Icon(EvaIcons.fileAdd),
                                ),
                                onTap: () async {
                                  productQuantity++;
                                  await FirebaseFirestore.instance
                                      .collection(widget.collectionName)
                                      .doc(FirebaseAuth.instance.currentUser!.email)
                                      .collection("items")
                                      .doc(_documentSnapshot.id)
                                      .update({'quantite': productQuantity});
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        child: CircleAvatar(
                          child: Icon(EvaIcons.fileRemove),
                        ),
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection(widget.collectionName)
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("items")
                              .doc(_documentSnapshot.id)
                              .delete();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentScreen()),);

                
                },
                child: Text(
                  'Payer \$${total.toStringAsFixed(2)}', // Afficher le total
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}