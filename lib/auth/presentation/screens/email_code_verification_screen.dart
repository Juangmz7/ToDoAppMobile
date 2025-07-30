import 'package:flutter/material.dart';
import 'package:todo_app/auth/presentation/widgets/widgets.dart';


class EmailCodeVerificationScreen extends StatelessWidget {
  const EmailCodeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric( vertical: 200),
          child: Column(
            children: [
        
              Text('Código de verificación', style: textStyle.titleMedium),
        
              const SizedBox(height: 20),
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 120),
                child: CustomTextFormField(
                  labelText: 'Introduce código',
                  keyboardType: TextInputType.number,
                ),
              ),
        
              const SizedBox(height: 20),
        
              FilledButton(onPressed: () {}, child: Text('Verificar'))
              
            ],
          ),
        ),
      ),
    );
  }
}

