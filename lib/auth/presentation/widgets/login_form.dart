
import 'package:flutter/material.dart';
import 'package:todo_app/auth/presentation/widgets/custom_text_form_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.only(    // To scroll up the form
        top: 0,
        bottom: keyboardHeight + 40 
      ),
      physics: const ClampingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: size.width*0.75,
        alignment: Alignment.center,
        child: Column(
          children: [

            Text('Login', style: textStyle.titleMedium),

            const SizedBox(height: 20,),

            //* Username form
            CustomTextFormField(
              hintText: 'Introduce usuario',
              labelText: 'Usuario',
            ),
      
            const SizedBox(height: 20),

            //* Password form
            CustomTextFormField(
              hintText: 'Introduce contraseña',
              labelText: 'Contraseña',
            ),

            const SizedBox(height: 10,),

            //* Redirection to forgot_password screen

            TextButton(
              onPressed: () {}, //ToDo
              child: Text('¿Olvidaste tu contraseña?', style: textStyle.titleSmall)
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                
                Text('¿Aún no tienes cuenta?', style: textStyle.titleSmall),

                //* Redirection to register_screen
                TextButton(
                  onPressed: () {}, //ToDo
                  child: Text('Regístrate aquí!', style: TextStyle(color: Colors.blue))
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}