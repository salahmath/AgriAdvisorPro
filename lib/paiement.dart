// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print, unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  bool showSuccessfulAnimation = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
late DateTime selectedDate;

  // Function to open a date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
  // Function to simulate a successful payment
  void simulatePayment() async {
    String cardNumber = cardNumberController.text;
    String cvv = cvvController.text;

    // Perform payment logic here (you can add your actual payment logic).

    // Simulate a delay for demonstration purposes.
    await Future.delayed(Duration(seconds: 2));

    try {
      final cardQuery = await _firestore
          .collection('card_numbers')
          .where('number', isEqualTo: cardNumber)
          .get();

      if (cardQuery.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Card number already exists!'),
          ),
        );
      } else {
        await _firestore.collection('card_numbers').add({
          'number': cardNumber,
          'cvv': cvv,
          'timestamp': FieldValue.serverTimestamp(),
        });

        setState(() {
          showSuccessfulAnimation = true;
        });

        // Reset the animation after a certain period.
        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            showSuccessfulAnimation = false;
          });
        });
      }
    } catch (e) {
      print('Error saving card number: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!showSuccessfulAnimation) ...[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Card Number (16 digits)',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'CVV (3 digits)',
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  _selectDate(context); // Ouvre le sélecteur de date
                },
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 16.0),
                    Text('Expiration Date'),
                  ],
                ),
              ),
            ),
              ElevatedButton(
                onPressed: () {
                  simulatePayment();
                },
                child: Text('Make Payment'),
              ),
            ],
            if (showSuccessfulAnimation)
              FlareActor(
                '', // Replace with the path to your Flare animation file.
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: 'success', // Specify the animation name.
              ),
          ],
        ),
      ),
    );
  }
}
