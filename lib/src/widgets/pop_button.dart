import 'package:flutter/material.dart';

class PopButton extends StatelessWidget {
  const PopButton({super.key, this.popText});
  final String? popText;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(popText ?? "Cancel"),
    );
  }
}
