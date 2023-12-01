// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api, use_key_in_widget_constructors, avoid_print, deprecated_member_use

import 'package:app_commerce/const/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController ?_nameController;
  TextEditingController ?_phoneController;
  TextEditingController ?_ageController;


  setDataToTextField(data){
    return  Column(
      children: [
        TextFormField(
          controller: _nameController = TextEditingController(text: data['name']),
          decoration: InputDecoration(
            prefixIcon: Icon(EvaIcons.personOutline), // Icône EvaIcons pour le téléphone
            fillColor: Colors.grey[200], // Couleur de fond
            filled: true,
          ),
        ),
        TextFormField(
          controller: _phoneController = TextEditingController(text: data['phone']),
           decoration: InputDecoration(
            prefixIcon: Icon(EvaIcons.phoneOutline), // Icône EvaIcons pour le téléphone
            fillColor: Colors.grey[200], // Couleur de fond
            filled: true,
          ),
        ),
        TextFormField(
           decoration: InputDecoration(
            prefixIcon: Icon(EvaIcons.calendarOutline), // Icône EvaIcons pour le téléphone
            fillColor: Colors.grey[200], // Couleur de fond
            filled: true,
          ),
          controller: _ageController = TextEditingController(text: data['age']),
          
        ),
        ElevatedButton(
  onPressed: () => updateData(),
  style: ElevatedButton.styleFrom(
    primary: AppColors.deep_orange, // Couleur de fond du bouton
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r), // Bordure arrondie
    ),
  ),
  child: Container( // Conteneur pour personnaliser le fond du bouton
    decoration: BoxDecoration(
      
      borderRadius: BorderRadius.circular(12.r), // Bordure arrondie
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Update",
        style: TextStyle(
          fontSize: 16.sp,
          color: Color.fromARGB(255, 255, 255, 255), // Couleur du texte du bouton
        ),
      ),
    ),
  ),),],);
  }


  updateData(){
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update(
        {
          "name":_nameController!.text,
          "phone":_phoneController!.text,
          "age":_ageController!.text,
        }
        ).then((value) => print("Updated Successfully"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if(data==null){
              return Center(child: CircularProgressIndicator(),);
            }
            return setDataToTextField(data);
          },

        ),
      )),
    );
  }
}
