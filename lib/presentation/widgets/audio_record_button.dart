
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/providers/task_recorder_provider.dart';
import 'package:todo_app/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:todo_app/shared/shared.dart';


class AudioRecordButton extends ConsumerStatefulWidget {

  final double? size;

  const AudioRecordButton({
    super.key,
    this.size
  });

  @override
  ConsumerState<AudioRecordButton> createState() => _AudioRecordButtonState();
}

class _AudioRecordButtonState extends ConsumerState<AudioRecordButton> {

  bool isRecording = false;

  @override
  void initState() {
    super.initState();
  }

  void startRecording() {
    ref.read(taskRecorderProvider.notifier).onRecordStarted();
  }

  void stopRecording() {
    ref.read(taskRecorderProvider.notifier).onRecordStopped();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    ref.listen(taskRecorderProvider, (previous, next) {

      if ( next.errorMessage != null && next.errorMessage!.isNotEmpty ) {
        showSnackbar(context, next.errorMessage!);
      }

    });

    final isPosting = ref.watch(taskRecorderProvider).isPosting;

    return FloatingActionButton(
      heroTag: 'recordAudioButton',
      onPressed: () {

        if( isRecording ) {
          ref.read(taskRecorderProvider.notifier).onRecordStopped();

          // Set the state to not recording
          setState(() {
            isRecording = false;
          });

        } else {

          ref.read(taskRecorderProvider.notifier).onRecordStarted();

          setState(() {
            isRecording = true;
          });

        }
      },
      backgroundColor: const Color.fromARGB(255, 173, 63, 193),
      splashColor: Colors.purple,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.size ?? 30),
      ),
      child: isPosting ?
        const CustomCircularProgressIndicator() 
        :
        Icon(
          size: widget.size,
          isRecording ? Icons.stop : Icons.mic,
      ),
    );
  }
}