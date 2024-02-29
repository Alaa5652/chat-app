import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, this.ontap});
  String? text;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: const Color(0xffc7ede6), ),
        height: 42,
        width: double.infinity,
        child: Center(child: Text(text ?? '',style: TextStyle(fontSize: 22),)),
      ),
    );
  }
}
