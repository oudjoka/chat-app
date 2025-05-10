 
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showSnackBar({
    required BuildContext context,
    FirebaseAuthException? e,
    required String message,
    bool isSuccess = false, // Added flag for success condition
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e == null
              ? message // If 'e' is null, show only 'message'
              : "$message\n${e.message ?? 'No additional error message'}", // If 'e' is not null, show both
        ),
        backgroundColor:
            isSuccess ? Colors.green : Colors.red, // Success: green, Error: red
      ),
    );
  }

  