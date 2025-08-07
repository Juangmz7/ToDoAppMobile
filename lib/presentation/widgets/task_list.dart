import 'package:flutter/material.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/presentation.dart';


class TaskList extends StatefulWidget {

  final List<Task> tasks;

  const TaskList({
    super.key,
    required this.tasks
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
  }

  // Initilize form controllers
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

    if (widget.tasks.isEmpty) {
      return CustomTaskFormField(
        height: taskHeight,
        width: taskWidth,
        onChanged: null,
        hintText: 'No hay tareas para hoy',
        padding: EdgeInsets.only(left: size.width*0.18),
      );
    }

    _initControllers();

    return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {

                final task = widget.tasks[index];

                return Column(
                  children: [

                    CustomTaskFormField(
                      height: taskHeight,
                      width: taskWidth,
                      onChanged: null,
                      controller: _controllers[index],
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