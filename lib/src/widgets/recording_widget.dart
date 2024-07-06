import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:smart_piggy/util/color_resources.dart';

class RecordingWidget extends StatefulWidget {
  final ValueChanged<File> onRecordDone;

  const RecordingWidget({
    super.key,
    required this.onRecordDone,
  });

  @override
  State<RecordingWidget> createState() => _RecordingWidgetState();
}

class _RecordingWidgetState extends State<RecordingWidget> {
  late final AudioRecorder _audioRecorder;

  bool _recording = false;

  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<Directory> _getRecordingDirectory() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final recordingsDirectoryPath = "${appDocumentsDir.path}/recordings";
    final Directory recordingsDirectory = Directory(recordingsDirectoryPath);
    final exist = await recordingsDirectory.exists();
    if (!exist) {
      await recordingsDirectory.create();
    }
    return recordingsDirectory;
  }

  Future<String> _getFilePath() async {
    final Directory recordingsDirectory = await _getRecordingDirectory();
    return "${recordingsDirectory.path}/recording.m4a";
  }

  Future<void> _startRecording() async {
    if (await _audioRecorder.hasPermission()) {
      final filePath = await _getFilePath();
      if (mounted) {
        setState(() {
          _recording = true;
        });
      }
      await _audioRecorder.start(
        const RecordConfig(),
        path: filePath,
      );
    }
  }

  Future<void> _stopRecording() async {
    setState(() {
      _recording = false;
    });
    final _ = await _audioRecorder.stop();
    final record = File(await _getFilePath());
    widget.onRecordDone(record);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _recording = !_recording;
        });
      },
      child: _recording
          ? GestureDetector(
              onTap: _stopRecording,
              child: RippleAnimation(
                color: Colors.green,
                delay: const Duration(milliseconds: 300),
                repeat: true,
                minRadius: 45,
                ripplesCount: 6,
                duration: const Duration(milliseconds: 6 * 300),
                child: Icon(
                  Icons.pause,
                  color: ColorResources.getWhiteColor(),
                ),
              ),
            )
          : GestureDetector(
              onTap: _startRecording,
              child: Icon(
                Icons.mic,
                color: ColorResources.getWhiteColor(),
              ),
            ),
    );
  }
}
