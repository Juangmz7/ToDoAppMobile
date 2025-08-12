


// StateNotifierprovider
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/providers/providers.dart';
import 'package:todo_app/states/states.dart';


final taskRecorderProvider = StateNotifierProvider<TaskRecorderNotifier, TaskRecorderState>(
  (ref) => TaskRecorderNotifier(
    recordSendCallback: ref.read(taskRepositoryProvider).audioTaskSender,
    ref: ref
  ),
);

class TaskRecorderNotifier extends StateNotifier<TaskRecorderState> {

  final Future<Task> Function(File) recordSendCallback;
  final Ref ref;

  TaskRecorderNotifier({
    required this.recordSendCallback,
    required this.ref
  })
  :super(TaskRecorderState(audioRecorder: AudioRecorder()));


// OnRecordStarted
void onRecordStarted() async {

  // Check if permissions are granted
  bool hasPermission = await state.audioRecorder.hasPermission();
  if ( !hasPermission ) {
    return;
  } 

  final tempDir = await getTemporaryDirectory();
  final filePath = '${tempDir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

  await state.audioRecorder.start(
    const RecordConfig(),
    path: filePath
  );
  
}

// OnRecordStopped
void onRecordStopped() async {
  // Stop recording
  final path = await state.audioRecorder.stop();

  if (path == null) {
    // Handle the case where recording was not successful
    return;
  }

  final file = File(path);

  state = state.copyWith(
    isPosting: true
  );
  
  try {
    // Send the recorded audio file
    await onRecordSend(file);
  } catch (e) {

    state = state.copyWith(
    isPosting: false,
    errorMessage: e.toString()
    );

  }

  state = state.copyWith(
    isPosting: false
  );

  // Delete the file if needed
  await file.delete();

}

Future<void> onRecordSend(File path) async {

  // Request
  final task = await recordSendCallback(path);

  // Refresh the task list with the new task
  ref.read(tasksListProvider.notifier).refreshTaskList(task);

}

}