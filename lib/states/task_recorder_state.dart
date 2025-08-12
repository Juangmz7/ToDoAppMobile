

import 'package:record/record.dart';

class TaskRecorderState {
  final AudioRecorder audioRecorder;
  final bool isPosting;
  final String? errorMessage;

  TaskRecorderState({
    required this.audioRecorder,
    this.isPosting = false,
    this.errorMessage,
  });

  TaskRecorderState copyWith({
    AudioRecorder? audioRecorder,
    bool? isPosting,
    String? errorMessage,
  }) {
    return TaskRecorderState(
      audioRecorder: audioRecorder ?? this.audioRecorder,
      isPosting: isPosting ?? this.isPosting,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
