import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        width: 150,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        )
    ),
  );
}