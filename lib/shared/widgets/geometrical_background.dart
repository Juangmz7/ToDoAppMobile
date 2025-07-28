import 'package:flutter/material.dart';

class GeometricalBackground extends StatelessWidget {

  final Color upperColor;
  final Color downsideColor;
  final Widget child;

  const GeometricalBackground({
    super.key,
    required this.upperColor,
    required this.downsideColor,
    required this.child
  });


  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    
    return SizedBox.expand(
      child: Stack(
        children: [
          
          Align(
            alignment: Alignment(-0.7, -1.55), // Top left
            child: _Circle(
              color: upperColor,
              height: size.width * 0.7,
              width: size.width * 0.7,
            ),
          ),
      
          Align(
            alignment: Alignment(-3, -1.2), // Top left
            child: _Circle(
              color: downsideColor,
              height: size.width * 0.7,
              width: size.width * 0.7,
            ),
          ),
      
          Align(
            alignment: Alignment(0.8, 1.6), // Bottom right
            child: _Circle(
              color: upperColor,
              height: size.width * 0.7,
              width: size.width * 0.7,
            ),
          ),
      
          Align(
            alignment: Alignment(3.5, 1.2), // Bottom right
            child: _Circle(
              color: downsideColor,
              height: size.width * 0.7,
              width: size.width * 0.7,
            ),
          ),

          Align(
            alignment: Alignment(0,-0.1),
            child: child,
          )
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {

  final Color color;
  final double height;
  final double width;

  const _Circle({
    required this.color,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(150)
      ),
      height: height,
      width: width,
    );
  }
}