
import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/presentation/widgets/custom_task_form_field.dart';


class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.65,
      width: size.width * 0.85,
      child: Column(
        children: [

          //* Date Header
          SizedBox(
            height: size.height * 0.05,
            width: size.width * 0.85,
            child: Center(
              child: Text(
                'Fecha Actual',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          const SizedBox(height: 30),
          
          //* Task List
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                  return Column(
                    children: [

                      CustomTaskFormField(
                        height: size.height * 0.07,
                        width: size.width * 0.85,
                        onChanged: null,
                        prefixIcon: IconButton(
                          onPressed: () {},
                          color: const Color.fromARGB(255, 174, 54, 244),
                          icon: const Icon(Icons.circle_outlined)
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
                            child: Text('urgent')
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                    ],
                  );
              },
              itemCount: 10,
              scrollDirection: Axis.vertical,
            ),
          ),

        ],
      ),
    );
  }
}