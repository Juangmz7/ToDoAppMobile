
import 'package:flutter/material.dart';

Future<DateTime> showDatePickerDialog({
  required BuildContext context,
  required DateTime initialDate,
  ValueChanged<DateTime>? onDateSelected,
}) {
  return showDatePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    initialDate: initialDate,
  ).then((selectedDate) {
    if (selectedDate != null && onDateSelected != null) {
      onDateSelected(selectedDate);
    }
    return selectedDate ?? initialDate; // Return the selected date or the initial date if none was selected
  });
}
