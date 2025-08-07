
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeDateProvider = StateProvider<DateTime>((ref) { //TODO: move it to other
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});