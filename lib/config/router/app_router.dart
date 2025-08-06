
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/presentation.dart';

import 'package:todo_app/presentation/screens/screens.dart';


final appRouter = GoRouter(

  //initialLocation: '/login',
  initialLocation: '/home-tasks',
  routes: [

    //* Auth routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
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

    //* Tasks routes
    GoRoute(
      path: '/home-tasks',
      builder: (context, state) => const HomeTasksScreen(),
    ),

    GoRoute(
      path: '/task',
      builder: (context, state) => const TaskScreen(),
    ),
  ],

  //ToDo: redirections


);