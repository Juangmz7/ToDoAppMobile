import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app/auth/presentation/presentation.dart';

class ForgotPasswordTokenVerificationForm extends ConsumerWidget {
  const ForgotPasswordTokenVerificationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textStyle = Theme.of(context).textTheme;
    final emailCodeValidatorForm = ref.watch(emailCodeValidatorFormProvider);

    return Column(
      children: [
        Text('Código de verificación', style: textStyle.titleMedium),
        
              const SizedBox(height: 20),
        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: CustomTextFormField(
                  labelText: 'Introduce código',
                  keyboardType: TextInputType.number,
                  onChanged: ref.read(emailCodeValidatorFormProvider.notifier).onTokenChanged,
                  errorMessage: emailCodeValidatorForm.isFormPosted ?
                                  emailCodeValidatorForm.errorMessage :
                                  null,
                ),
              ),
        
        
              FilledButton(
                onPressed:  emailCodeValidatorForm.isPosting ? null : () {
                
                  FocusManager.instance.primaryFocus?.unfocus();

                  ref.read(emailCodeValidatorFormProvider.notifier).onFormSubmmit();

                },
                child: Text('Verificar')
              ),

      ],
    );
  }
}