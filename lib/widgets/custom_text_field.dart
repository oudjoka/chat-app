import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({super.key, this.hintText, this.onChanged, this.obscureText=false});
  final String? hintText;
  final Function(String)? onChanged;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText! ,
      validator: (data) {
        //String data = value!.trim(); problem of autocomplete, autocomplete string don't work but hand writing work , but still the answer is not satisfy he don't remove the biginning space
        if (data!.isEmpty) {
          return 'The field is required';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border:const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
