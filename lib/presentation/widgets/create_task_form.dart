import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/dialogs/dialogs.dart';
import 'package:todo_app/presentation/presentation.dart';


class CreateTaskForm extends ConsumerStatefulWidget {
  const CreateTaskForm({super.key});

  @override
  ConsumerState<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends ConsumerState<CreateTaskForm> {

  final TextEditingController taskController = TextEditingController();
  
  late TaskPriority selectedPriority;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedPriority = TaskPriority.low; // Initialize with a default priority
    selectedDate = ref.read(activeDateProvider); // Initialize with the current date
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
        height: size.height * 0.5,
        width: size.width * 0.8,
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

            Divider(
              color: Color.fromARGB(255, 168, 163, 163),
              endIndent: size.width * 0.07,
              indent: size.width * 0.07,
            ),

            const SizedBox(height: 10),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 96, 19, 110),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                ),
              ),
              child: Text(
                'Seleccionar fecha: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: textStyle.titleSmall,
              ),
              onPressed: () async {

                selectedDate = await showDatePickerDialog(
                  context: context,
                  initialDate: selectedDate
                );

                setState(() {});
              }
            ),

            const SizedBox(height: 10),

            Divider(
              color: Color.fromARGB(255, 168, 163, 163),
              endIndent: size.width * 0.07,
              indent: size.width * 0.07,
            ),

            const SizedBox(height: 10),

            CustomFilledButton(
              label: 'Enviar',
              backgroundColor: const Color.fromARGB(255, 96, 19, 110),
              onPressed: () {

                // Send task request object
                ref.read(tasksListProvider.notifier).createTask(
                  body: taskController.text.trim(),
                  taskDate: selectedDate,
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