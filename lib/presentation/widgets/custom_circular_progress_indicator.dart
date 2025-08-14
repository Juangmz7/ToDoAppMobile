
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {

  final double? height;
  final double? width;

  const CustomCircularProgressIndicator({
    super.key,
    this.height, 
    this.width
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: SizedBox(
        height: height ?? size.width * 0.06,
        width: width ?? size.width * 0.06,
        child: CircularProgressIndicator(
          strokeWidth: size.width * 0.009,
        ),
      )
    );
  }
}