
import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/theme.dart';


class CustomTaskFormField extends StatelessWidget {

  final Color? color;
  final double height;
  final double width;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final EdgeInsets? padding;

  const CustomTaskFormField({
    super.key,
    this.color,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.padding,
    required this.height,
    required this.width, 
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
   
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppTheme.taskBoxColor,
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: Center(
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          style: textStyle.titleSmall,
          maxLines: null,

          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            contentPadding: padding ?? EdgeInsets.symmetric(vertical: size.height * 0.022),
          ),
        ),
      ),
    );
  
  }

}