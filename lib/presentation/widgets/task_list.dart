import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/presentation.dart';


class TaskList extends ConsumerStatefulWidget {

  final List<Task> tasks;

  const TaskList({
    super.key,
    required this.tasks
  });

  @override
  ConsumerState<TaskList> createState() => _TaskListState();
}

class _TaskListState extends ConsumerState<TaskList> {

  // Two mapps for each task
  Map<int, FocusNode> focusNodes = {};
  Map<int, TextEditingController> controllers = {};
  

  @override
  void initState() {
    super.initState();
  }

  // Initilize form controllers which initializes the form data
  TextEditingController _getTaskController(Task task) {
    
    // If this controller doesn´t exists it creates a new one
    if ( !controllers.containsKey(task.id) ) {
      controllers[task.id] = TextEditingController(text: task.body);
    }

    return controllers[task.id]!;

  }

  FocusNode _getTaskFocusNode(Task task) {

    // Add a permanent listener which executes every time it loose the focus
    // It listens to body changes when unfocus 
    // If it doesn´t exists it creates a new focusnode for this id
    if (!focusNodes.containsKey(task.id)) {

      final focusNode = FocusNode();

      focusNode.addListener(() {
      
      if ( focusNode.hasFocus ) return;

      // Modified label
      final newBody = controllers[task.id]?.text.trim();

      // If initial body is the same as the "modification"
      if ( task.body.trim() == newBody ) return;

      // Calls the notifier to update the task
      ref.read(tasksListProvider.notifier).updateTaskBody(task.id, newBody!);
        
    });

      // Asign the focusNode created with the listener to respective
      // position in map
      focusNodes[task.id] = focusNode;

    }

    return focusNodes[task.id]!;
    
  }

  @override
  void dispose() {

    controllers.forEach((_, controller) =>
      controller.dispose()
    );

    focusNodes.forEach((_, focusNode) => 
      focusNode.dispose()
    );

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final taskHeight = size.height * 0.07;
    final taskWidth = size.width * 0.85;
    final textStyle = Theme.of(context).textTheme;

    if (widget.tasks.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: AppTheme.taskBoxColor,
          borderRadius: BorderRadius.circular(size.width * 0.05)
        ), 
        height: taskHeight,
        width: taskWidth,
        padding: EdgeInsets.only(left: size.width*0.18),
        child: Center(
          child: Text('No hay tareas para hoy'),
        ),

      );
    }

    return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {

                final task = widget.tasks[index];

                return Column(
                  children: [

                    CustomTaskFormField(
                      height: taskHeight,
                      width: taskWidth,
                      focusNode: _getTaskFocusNode(task),
                      controller: _getTaskController(task),
                      style: task.isCompleted ?
                        TextStyle(
                          fontFamily: textStyle.titleSmall?.fontFamily,
                          decoration: TextDecoration.lineThrough
                        )
                      : null,
                      prefixIcon: IconButton(
                        onPressed: () {
                          if ( _getTaskFocusNode(task).hasFocus ) return;
                          ref.read(tasksListProvider.notifier).toggleTaskCompletion(task.id);
                        },                           
                        color: const Color.fromARGB(255, 174, 54, 244),
                        icon: task.isCompleted ? const Icon(Icons.check_circle_rounded) : const Icon(Icons.circle_outlined)
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.01),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 174, 54, 244),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                          ),
                          onPressed: () {},
                          child: Text(task.priority.name)
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                  ],
                );
              },
              itemCount: widget.tasks.length,
              scrollDirection: Axis.vertical,
            ),
          );
  }
}