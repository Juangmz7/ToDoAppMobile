import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/domain/infrastructure/mappers/task_mapper.dart';

class DateHeader extends StatelessWidget {

  final DateTime date;
  final SwiperController swiperController;

  DateHeader({
    super.key,
    required this.date,
    required this.swiperController
  });

  final List<String> _weekdays = [
  '', // índice 0 no se usa
  'Lunes',
  'Martes',
  'Miércoles',
  'Jueves',
  'Viernes',
  'Sábado',
  'Domingo',
];

  String _dateToDayOfTheWeek() {

      final nowDate = DateTime.now();
      final now = DateTime(nowDate.year, nowDate.month, nowDate.day);


      //* Date is today
      if ( now == date ) return 'Hoy';

      //* Date was yesterday 
      if ( date.add(Duration(days: 1)).isAtSameMomentAs(now) ) return 'Ayer';

      //* Date will be tommorrow
      if ( now.add(Duration(days: 1)).isAtSameMomentAs(date) ) return 'Mañana';

      // Returns the day of the week
      return _weekdays[date.weekday];
    }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    final formattedDate = _dateToDayOfTheWeek();

    return SizedBox(
            height: size.height * 0.09,
            width: size.width * 0.85,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  IconButton(
                    onPressed: () => swiperController.previous(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded
                    )
                  ),
                  
                  const SizedBox(width: 10),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //* Day of the week
                      Text(
                        formattedDate,
                        style: textStyle.titleSmall,
                      ),

                      SizedBox(height: size.width * 0.005),

                      //* Complete date (dd/mm/yyyy)
                      Text('(${TaskResponse.dateTimeToNormalFormat(date)})', style: textStyle.titleSmall),
                    ],
                  ),

                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () => swiperController.next(),
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