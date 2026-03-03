import 'package:flutter/material.dart';

class MatrialButTonWidget extends StatelessWidget {
  const MatrialButTonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Color(0xFFF59239),
      minWidth: double.infinity,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
