
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/config.dart';

typedef TaskFilterDialogCallback = void Function(BuildContext);

class TaskFilterMenuDialog {

  static void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: _taskFilterDialogBuilder
    );

  }
}

Widget _taskFilterDialogBuilder(BuildContext context) {

  final size = MediaQuery.of(context).size;
  final height = size.height*0.44;
  final width = size.width*0.5;
  final textStyle = Theme.of(context).textTheme;
 
  return Consumer(
    builder: (context, ref, child) {
      
      return Dialog(
        backgroundColor: AppTheme.taskBoxColor,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              const SizedBox(height: 15),

              //* Order by options
              Text('Ordernar por: ', style: textStyle.titleSmall),

              _CustomFilledButton(
                label: 'Mayor prioridad',
                onPressed: () {
                  
                },
              ),

              _CustomFilledButton(
                label: 'Menor prioridad',
                onPressed: () {}
              ),

              const SizedBox(height: 15),

              Text('Prioridad:', style: textStyle.titleSmall),


              _CustomFilledButton(
                label: 'Urgente',
                onPressed: null,
              ),

              _CustomFilledButton(
                label: 'Alta',
                onPressed: null,
              ),

              _CustomFilledButton(
                label: 'Media',
                onPressed: null,
              ),

              _CustomFilledButton(
                label: 'Baja',
                onPressed: null,
              )

            ],
          ),
        ),
      );
    },
  );
}

class _CustomFilledButton extends StatelessWidget {

  final String label;
  final Function()? onPressed;
  
  const _CustomFilledButton({
    this.onPressed,
    required this.label,
  });


  @override
  Widget build(BuildContext context) {
    
    final textStyle = Theme.of(context).textTheme;

    return Center(
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 174, 54, 244)
        ),
        onPressed: onPressed,
        child: Text(label, style: textStyle.titleSmall) 
      ),
    );
  }
}

