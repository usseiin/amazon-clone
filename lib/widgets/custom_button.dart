import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.btnText,
    required this.onPress,
    this.btnColor,
  }) : super(key: key);
  final String btnText;
  final VoidCallback onPress;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        primary: btnColor,
        minimumSize: const Size(
          double.infinity,
          50,
        ),
      ),
      child: Text(
        btnText,
        style: TextStyle(
          color: btnColor == null ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
