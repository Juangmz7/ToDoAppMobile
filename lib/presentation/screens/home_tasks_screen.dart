import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/presentation/widgets/task_filters.dart';
import 'package:todo_app/presentation/widgets/task_list_slideshow.dart';
import 'package:todo_app/presentation/widgets/widgets.dart';

class HomeTasksScreen extends StatelessWidget {
  const HomeTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
      
          Scaffold(
            backgroundColor: AppTheme.taskPagesBackground,
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    size: size.width * 0.09,
                    Icons.menu_rounded
                  )
                ),
              ),
              backgroundColor: AppTheme.taskPagesBackground,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      size: size.width * 0.09,
                      Icons.search_rounded
                    )
                  ),
                )
              ],
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                Text('Bienvenido user500', style: textStyle.titleLarge),
      
                SizedBox(height: 30),
                
                //* Filters for the tasks
                TaskFilters(
                  taskFilterDialogCallback: TaskFilterMenuDialog.openDialog,
                ),
      
                const SizedBox(height: 20),
              
                //* Title with date (scrollable to next or previous day)
                const TaskListSlideshow(),
                
                SizedBox(height: 40 ),
              
                ],
              ),
            ),
            
          ),


          //* Floating action button to add a new task
          Positioned(
            bottom: size.height * 0.05,
            right: size.width * 0.09,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color.fromARGB(255, 173, 63, 193),
              splashColor: Colors.purple,
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size.width * 0.07),
              ),
              child: Icon(
                size: size.width * 0.07,
                Icons.add_rounded
              ),
            ),
          ),
        ],
      ),
    );
  
  }
}