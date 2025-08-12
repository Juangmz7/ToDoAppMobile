import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {

  final String label;
  final Function()? onPressed;
  final Color? backgroundColor;
  
  const CustomFilledButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    required this.label,
  });


  @override
  Widget build(BuildContext context) {
    
    final textStyle = Theme.of(context).textTheme;

    return Center(
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color.fromARGB(255, 174, 54, 244)
        ),
        onPressed: onPressed,
        child: Text(label, style: textStyle.titleSmall) 
      ),
    );
  }
}