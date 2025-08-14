import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/presentation/dialogs/dialogs.dart';
import 'package:todo_app/presentation/widgets/audio_record_button.dart';
import 'package:todo_app/presentation/widgets/side_menu.dart';
import 'package:todo_app/presentation/widgets/widgets.dart';

class HomeTasksScreen extends StatefulWidget {
  
  const HomeTasksScreen({super.key});

  @override
  State<HomeTasksScreen> createState() => _HomeTasksScreenState();
}

class _HomeTasksScreenState extends State<HomeTasksScreen> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
      
          Scaffold(
            key: scaffoldKey,
            drawer: SideMenu(scaffoldKey: scaffoldKey),
            resizeToAvoidBottomInset: false,            
            backgroundColor: AppTheme.taskPagesBackground,
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  // Opens the side menu
                  onPressed: () => scaffoldKey.currentState?.openDrawer(),
                  icon: Icon(
                    size: size.width * 0.09,
                    Icons.menu_rounded
                  )
                ),
              ),
              backgroundColor: AppTheme.taskPagesBackground,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
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
            body: SingleChildScrollView(
              reverse: true,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                
                  Text('Bienvenido admin', style: textStyle.titleLarge),
                      
                  SizedBox(height: 30),
                  
                  //* Filters for the tasks
                  TaskFilters(
                    taskFilterDialogCallback: TaskFilterMenuDialog.openDialog,
                  ),
                      
                  const SizedBox(height: 10),
                
                  //* Title with date (scrollable to next or previous day)
                  const TaskListSlideshow(),
                  
                  SizedBox(height: 40 ),
                
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 10
                    ),
                  )
                
                  ],
                ),
              ),
            ),
            
          ),


          //* Floating action button to record audio for a task
          Positioned(
              bottom: size.height * 0.05,
              right: size.width * 0.25,
            child: AudioRecordButton(
              size: size.width * 0.07,
            ),
          ),

          //* Floating action button to create a new task
          Positioned(
              bottom: size.height * 0.05,
              right: size.width * 0.06,
              child: AddTaskButton(
                size: size.width * 0.07,
              ),
          ),
          
        ],
      ),
    );
  
  }
}