
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/screens/login_screen.dart';

final appRouter = GoRouter(

  initialLocation: '/login',
  //initialLocation: '/home',
  routes: [

    //* Auth routes
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
  ],

  // redirect: null


);