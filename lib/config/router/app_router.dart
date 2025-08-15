
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/presentation.dart';
import 'package:todo_app/auth/state/auth_state.dart';
import 'package:todo_app/config/config.dart';

import 'package:todo_app/presentation/screens/screens.dart';


final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
  initialLocation: '/loading',
  refreshListenable: goRouterNotifier,
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
      path: '/loading',
      builder: (context, state) => const LoadingScreen(),
    ),
  ],

  redirect: (context, state) {
    
    final authStatus = goRouterNotifier.authStatus;
    final isGoingTo = state.matchedLocation;

    if ( isGoingTo == '/loading' && authStatus == AuthStatus.checking ) {
      return null;
    }

    if ( authStatus == AuthStatus.notAuthenticated  ) {
      if ( isGoingTo == '/login' || 
           isGoingTo == '/register' || 
           isGoingTo == '/forgot-password' || 
           isGoingTo == '/forgot-password/code-verification' ||
           isGoingTo == '/register-succedeed' ) {
        return null; // Allow navigation to these routes
      }
      return '/login'; // Redirect to login if not authenticated
    }

    if ( authStatus == AuthStatus.authenticated ) {
      if ( isGoingTo == '/login' || 
           isGoingTo == '/register' || 
           isGoingTo == '/forgot-password' || 
           isGoingTo == '/forgot-password/code-verification' ||
           isGoingTo == '/register-succedeed' || 
           isGoingTo == '/loading') {
        return '/home-tasks'; // Redirect to home tasks if authenticate-d
      }
      return null; // Allow navigation to other routes
    }


    return null; // Default case, no redirection needed

  },


);
});