import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/config.dart';
import 'package:todo_app/presentation/presentation.dart';


class CreateTaskDialog {


  static void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: _createTaskDialogBuilder
    );

  }

}

Widget _createTaskDialogBuilder(BuildContext context) {
        
  return GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Dialog(
      backgroundColor: AppTheme.taskPagesBackground,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: CreateTaskForm()
      )
    ),
  );

}