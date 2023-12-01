// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:app_commerce/widgets/fetchProducts.dart'; // Assurez-vous que le chemin d'importation est correct
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MyWidget("users-cart-items"), // Utilisez MyWidget avec le nom de la collection appropriée
      ),
    );
  }
}
