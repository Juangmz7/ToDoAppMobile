
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/presentation.dart';


import 'package:todo_app/tasks_screen.dart';

final appRouter = GoRouter(

  initialLocation: '/login',
  //initialLocation: '/home',
  routes: [

    //* Auth routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/tasks',
      builder: (context, state) => const TaskScreen(),
    ),
    
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: '/register-succedeed',
      builder: (context, state) => const RegisterSucceddedScreen(),
    ),

    GoRoute(
      path: '/forgot-password/code-verification',
      builder: (context, state) => const EmailCodeVerificationScreen(),
    ),

  ],

  //ToDo: redirections


);