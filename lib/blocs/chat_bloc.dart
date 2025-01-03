import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../data/vos/ticket_vo.dart';
import '../network/firebase_api.dart';

class ChatBloc extends ChangeNotifier {
  bool isDisposed = false;
  final String ticketId;
  TicketVo? ticket;
  final FirebaseApi _api = FirebaseApi();
  File? image;
  File? audio;
  TextEditingController msgController = TextEditingController();
  bool isRecording = false;
  final record = AudioRecorder();

  ChatBloc(this.ticketId) {
    listenChat();
  }

  void sendMsg() async {
    if (audio != null) {
      await _api.sendMessage(ticketId: ticketId, message: '', messageType: MessageType.voice, file: audio);
      audio = null;
      safeNotifyListeners();
    } else if (msgController.text.isNotEmpty || image != null) {
      await _api.sendMessage(ticketId: ticketId, message: msgController.text, messageType: image == null ? MessageType.text : MessageType.image, file: image);
      msgController.clear();
      image = null;
      safeNotifyListeners();
    }
  }

  void listenChat() {
    _api.getTicketById(ticketId).listen(
      (event) {
        ticket = event;
        safeNotifyListeners();
      },
    );
  }

  void pickImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      image = File(imageFile.path);
      safeNotifyListeners();
    }
  }

  void startRecordingAudio() async {
    if (await record.hasPermission()) {
      if (isRecording) {
        return;
      } else {
        try {
          isRecording = true;
          var path = await getApplicationDocumentsDirectory();
          print("PATH: ${path.path}");
          await record.start(const RecordConfig(encoder: AudioEncoder.wav), path: '${path.path}/${DateTime.now().millisecondsSinceEpoch}.wav');

          safeNotifyListeners();
        } catch (e) {
          print("ERROR WHILE RECORDING: $e");
        }
      }
    } else {
      Permission.audio.request().then(
        (value) {
          if (value.isGranted) {
            startRecordingAudio();
          }
        },
      );
    }
  }

  void completeRecordingAudio() async {
    if (!isRecording) {
      return;
    } else {
      isRecording = false;
      safeNotifyListeners();
      audio = File(await record.stop() ?? '');
      sendMsg();
      safeNotifyListeners();
    }
  }

  void cancelRecordingAudio() async {
    if (!isRecording) {
      return;
    } else {
      isRecording = false;
      await record.cancel();

      safeNotifyListeners();
    }
  }

  void safeNotifyListeners() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    record.dispose();
    super.dispose();
  }
}
