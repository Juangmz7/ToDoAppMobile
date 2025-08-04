import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {

  final Icon? prefixIcon;
  final String? labelText;
  final String? hintText;
  final String? errorMessage;
  final bool? filled;
  final Color? fillColor;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.filled = true,
    this.fillColor,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.errorMessage
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
    
  // State variable to toggle visibility of the password field
  bool isShowingField = false;

  @override
  Widget build(BuildContext context) {

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: Colors.white)
    );

    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2)
          )
        ]
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          labelText: widget.labelText,
          labelStyle: widget.errorMessage != null ? TextStyle(color: Colors.red) : null,
          hintText: widget.hintText,
          filled: widget.filled,
          isDense: true,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: border.copyWith( borderSide: const BorderSide( color: Colors.red )),
          errorText: widget.errorMessage,
          errorStyle: TextStyle(color: Colors.red),
          focusColor: colors.primary,
          suffixIcon:  widget.obscureText ? IconButton(
            onPressed: () => setState(() => isShowingField = !isShowingField),
            icon: isShowingField ? Icon(Icons.visibility_rounded, color: Colors.grey, size: 20)
                                 : Icon(Icons.visibility_off_rounded, color: Colors.grey, size: 20)
          )
          : null,

        ),
        onChanged: widget.onChanged,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        style: textStyle.titleSmall,
        obscureText: widget.obscureText && !isShowingField,

        
      ),
    );
  }
}