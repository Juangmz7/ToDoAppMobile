import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';


class RegisterSucceddedScreen extends StatelessWidget {
  const RegisterSucceddedScreen({super.key});

  //TODO: Agregar loading screen para las redirecciones

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¡Cuenta registrada correctamente!', style: textStyle.titleSmall),
        
            const SizedBox(height: 20),

            LottieBuilder.asset(
              'assets/animations/forgot_password_animation.json',
              repeat: true,
              width: size.width*0.5,
              height: size.height*0.3,
            ),

            const SizedBox(height: 30),

            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 71, 132, 238))
              ),
              onPressed: () => context.push('/login'),
              child: Text('Volver a inicio de sesión', style: textStyle.titleSmall)
            ),
        
          ],
        ),
      ),
    );
  }
}