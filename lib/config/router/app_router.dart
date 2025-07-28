
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/screens/login_screen.dart';
import 'package:todo_app/home_screen.dart';

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
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],

  // redirect: null


);