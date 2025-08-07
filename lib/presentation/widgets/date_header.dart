import 'package:flutter/material.dart';

class DateHeader extends StatelessWidget {

  final String date;

  const DateHeader({super.key,
    required this.date
});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
            height: size.height * 0.05,
            width: size.width * 0.85,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded
                    )
                  ),
                  
                  const SizedBox(width: 10),

                  Text(
                    date,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(width: 10),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded
                    )
                  )
                ],
              ),
            ),
          );
  }
}