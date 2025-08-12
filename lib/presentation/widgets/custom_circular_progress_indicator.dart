
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {

  final double verticalPadding;
  final double horizontalPadding;

  const CustomCircularProgressIndicator({
    super.key,
    this.verticalPadding = 15, 
    this.horizontalPadding = 15
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      child: CircularProgressIndicator(
        strokeWidth: size.width * 0.008,
      )
    );
  }
}