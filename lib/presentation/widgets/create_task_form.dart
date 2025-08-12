import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/presentation.dart';


class CreateTaskForm extends ConsumerStatefulWidget {
  const CreateTaskForm({super.key});

  @override
  ConsumerState<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends ConsumerState<CreateTaskForm> {

  final TextEditingController taskController = TextEditingController();
  late TaskPriority selectedPriority;

  @override
  void initState() {
    super.initState();
    selectedPriority = TaskPriority.low; // Initialize with a default priority
  }

  @override
  void dispose() {
    super.dispose();
    taskController.dispose();
  }

  bool isPrioritySelected (TaskPriority priority) {
    // Logic to check if the priority is selected
    return priority == selectedPriority; 
  }

  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme; 
    final selectedColor = const Color.fromARGB(255, 60, 7, 151); 

    return SizedBox(
        height: size.height * 0.75,
        width: size.width * 0.95,
        child: Column(
          children: [
      
            Text('Nueva tarea:', style: textStyle.titleMedium),
      
            const SizedBox(height: 20),
      
            CustomTaskFormField(
              height: size.height * 0.07,
              width: size.width * 0.7,
              hintText: 'Escribe el nombre de la tarea',
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              controller: taskController,
            ),

            const SizedBox(height: 20),
            
            Text('Seleccione la prioridad:', style: textStyle.titleMedium),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                //* Urgent
                CustomFilledButton(
                  label: TaskPriority.urgent.label,
                  backgroundColor: isPrioritySelected(TaskPriority.urgent) ? selectedColor : null,
                  onPressed: () {
                    
                    if (isPrioritySelected(TaskPriority.urgent)) return;

                    setState(() {
                      selectedPriority = TaskPriority.urgent;
                    });
              
                  },
                ),

                const SizedBox(width: 10),

                //* Medium
                CustomFilledButton(
                  label: TaskPriority.medium.label,
                  backgroundColor: isPrioritySelected(TaskPriority.medium) ? selectedColor : null,
                  onPressed: () {

                    if (isPrioritySelected(TaskPriority.medium)) return;

                    setState(() {
                      selectedPriority = TaskPriority.medium;
                    });
                    
                  }
                ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                //* High
                CustomFilledButton(
                  label: TaskPriority.high.label,
                  backgroundColor: isPrioritySelected(TaskPriority.high) ? selectedColor : null,
                  onPressed: () {

                    if (isPrioritySelected(TaskPriority.high)) return;

                    setState(() {
                      selectedPriority = TaskPriority.high;
                    });
                    
                  }
                ),

                const SizedBox(width: 25),
                
                //* Low
                CustomFilledButton(
                  label: TaskPriority.low.label,
                  backgroundColor: isPrioritySelected(TaskPriority.low) ? selectedColor : null,
                  onPressed: () {

                    if (isPrioritySelected(TaskPriority.low)) return;

                    setState(() {
                      selectedPriority = TaskPriority.low;
                    });
                    
                  }
                ),

              ],
            ),
            
            const SizedBox(height: 20),

            Text('Fecha:', style: textStyle.titleMedium), // TODO: Calendario

            const SizedBox(height: 10),

          Container( //! QUitar
              color: Colors.black,
              height: size.height * 0.3,
              width: size.height * 0.3,
            ),

            const SizedBox(height: 20),

            CustomFilledButton(
              label: 'Enviar',
              onPressed: () {

                // Send task request object
                ref.read(tasksListProvider.notifier).createTask(
                  body: taskController.text.trim(),
                  taskDate: DateTime.now(), //! Quitar cuando se implemente el calendario
                  priority: selectedPriority
                );           

                context.pop();

              },
            )

          ],
        ),
      );
  }
}