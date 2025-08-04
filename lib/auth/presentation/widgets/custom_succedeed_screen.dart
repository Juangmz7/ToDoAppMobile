
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class CustomSuccedeedScreen extends StatefulWidget {

  final String title;
  final String animationPath;
  final String redirectPath;

  const CustomSuccedeedScreen({
    super.key,
    required this.title,
    required this.animationPath,
    required this.redirectPath
  });

  @override
  State<CustomSuccedeedScreen> createState() => _CustomSuccedeedScreenState();
}

class _CustomSuccedeedScreenState extends State<CustomSuccedeedScreen> {
  @override
  Widget build(BuildContext context) {
    
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    bool isLoaded = false;

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //* Widget title
              Text(widget.title, style: textStyle.titleMedium),
          
              const SizedBox(height: 20),
      
              Stack(
                alignment: Alignment.center,
                children: [

                  if (!isLoaded)
                    const CircularProgressIndicator(),

                  FadeIn(
                    child: LottieBuilder.asset(
                    widget.animationPath,
                    repeat: true,
                    width: size.width*0.5,
                    height: size.height*0.3,
                    onLoaded: (_) => setState (
                      () => isLoaded = true
                    ),
                                    ),
                  ),
                ]
              ),
      
              const SizedBox(height: 30),
      
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 71, 132, 238))
                ),
                onPressed: () => context.push(widget.redirectPath),
                child: Text('Volver a inicio de sesión', style: textStyle.titleSmall)
              ),
          
            ],
          ),
        ),
      );
  }
}