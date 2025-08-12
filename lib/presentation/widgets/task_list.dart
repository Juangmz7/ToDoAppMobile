import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/dialogs/change_task_priority_dialog.dart';
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
        setState(() {});
        
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
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom; // TODO: Adjust for keyboard height

    if (widget.tasks.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: AppTheme.taskBoxColor,
          borderRadius: BorderRadius.circular(size.width * 0.05)
        ), 
        height: taskHeight,
        width: taskWidth,
        padding: EdgeInsets.only(left: size.width*0.03),
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
            
              FadeIn(
                child: CustomTaskFormField(
                  height: taskHeight,
                  width: taskWidth,
                  focusNode: _getTaskFocusNode(task),
                  controller: _getTaskController(task),
                  color: _getTaskFocusNode(task).hasFocus
                            ? const Color.fromARGB(255, 110, 1, 129) : null,
                  style: task.isCompleted ?
                    TextStyle(
                      fontFamily: textStyle.titleSmall?.fontFamily,
                      decoration: TextDecoration.lineThrough
                    )
                  : null,
                  prefixIcon: _getTaskFocusNode(task).hasFocus ?
                                 const SizedBox(height: 10, width: 10) :
                                _CustomPreffixIcon(
                                  task: task,
                                  focusNode: _getTaskFocusNode(task)
                                ),
                  suffixIcon: _getTaskFocusNode(task).hasFocus ?
                                null :
                                _CustomSuffixIcon(task: task)
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


class _CustomSuffixIcon extends StatelessWidget {

  final Task task;

  const _CustomSuffixIcon({
    required this.task
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.01),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: task.priority.color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        ),
        onPressed: () {
          final changeTaskPriorityDialog = ChangeTaskPriorityDialog(taskId: task.id);
          changeTaskPriorityDialog.openDialog(context);
        },
        child: Text(task.priority.label)
      ),
    );
  }
}

class _CustomPreffixIcon extends ConsumerWidget {

  final Task task;
  final FocusNode focusNode;

  const _CustomPreffixIcon({
    required this.task,
    required this.focusNode
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return IconButton(
      onPressed: () {
        if ( focusNode.hasFocus ) return;
        ref.read(tasksListProvider.notifier).toggleTaskCompletion(task.id);
      },                           
      color: const Color.fromARGB(255, 174, 54, 244),
      icon: task.isCompleted ? const Icon(Icons.check_circle_rounded) : const Icon(Icons.circle_outlined)
    );

  }
}