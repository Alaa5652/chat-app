import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, this.hinttext,this.onchange});
  String? hinttext;
  Function(String)?onchange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value==null)
          return 'required';
      },
      onChanged: onchange,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(borderSide: BorderSide(
          color: Colors.white
        )),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(
            color: Colors.white
        )),
      ),
    );
  }
}
