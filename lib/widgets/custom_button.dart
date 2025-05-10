import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
 const CustomButton({super.key, this.onTap,required this.buttonText});
 final String buttonText;
 final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Center(child: Text(this.buttonText)),
      ),
    );
  }
}
