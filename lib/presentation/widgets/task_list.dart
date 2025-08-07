import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  List<TextEditingController> _controllers = [];
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Add a permanent listener which executes every time it loose the focus
    // It listens to body changes when unfocus 
    focusNode.addListener(() {
      
      if ( focusNode.hasFocus ) return;

      for ( int i = 0; i < widget.tasks.length; i++ ) {
        
        final task = widget.tasks[i];
        final controller = _controllers[i];
        final newBody = controller.text.trim();

        // If initial body is the same
        if ( task.body.trim() == controller.text.trim()) return;

        // Calls the notifier to update the task
        ref.read(taskListFormProvider(task).notifier).updateBodyTask(newBody);
        
      }
    });
  }

  // Initilize form controllers which initializes the form data
  void _initControllers() {

    _controllers = widget.tasks.map(
      (task) => TextEditingController(text: task.body)
    ).toList();

  }

  @override
  void dispose() {

    for( final controller in _controllers ) {
      controller.dispose();
    }

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final taskHeight = size.height * 0.07;
    final taskWidth = size.width * 0.85;
    final textStyle = Theme.of(context).textTheme;

    if (widget.tasks.isEmpty) {
      return CustomTaskFormField(
        height: taskHeight,
        width: taskWidth,
        onChanged: null,
        //TODO: focusNode
        hintText: 'No hay tareas para hoy',
        padding: EdgeInsets.only(left: size.width*0.18),
      );
    }

    _initControllers();

    //TODO: Poner 2 mapas, uno de controladores y otro de focus

    return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {

                final task = widget.tasks[index];

                return Column(
                  children: [

                    CustomTaskFormField(
                      height: taskHeight,
                      width: taskWidth,
                      focusNode: focusNode,
                      controller: _controllers[index],
                      style: task.isCompleted ?
                        TextStyle(
                          fontFamily: textStyle.titleSmall?.fontFamily,
                          decoration: TextDecoration.lineThrough
                        )
                      : null,
                      prefixIcon: IconButton(
                        onPressed: () {},
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