import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/presentation/presentation.dart';

class ForgotPasswordTokenVerificationForm extends ConsumerWidget {
  const ForgotPasswordTokenVerificationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textStyle = Theme.of(context).textTheme;

    return Column(
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
        
        
              FilledButton(
                onPressed: () {
                
                  FocusManager.instance.primaryFocus?.unfocus();

                  ref.read(forgotPasswordProvider.notifier).checkEmailToken;

                },
                child: Text('Verificar')
              ),

      ],
    );
  }
}