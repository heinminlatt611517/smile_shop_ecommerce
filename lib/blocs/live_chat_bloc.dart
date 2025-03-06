import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:smile_shop/data/vos/login_data_vo.dart';
import 'package:smile_shop/data/vos/user_vo.dart';
import 'package:smile_shop/utils/strings.dart';

import '../data/model/smile_shop_model.dart';
import '../data/model/smile_shop_model_impl.dart';
import '../data/vos/chat_vo.dart';
import '../network/firebase_api.dart';

class LiveChatBloc extends ChangeNotifier {
  final SmileShopModel _smileShopModel = SmileShopModelImpl();

  ///states
  bool isDisposed = false;
  String? chatId;
  ChatVo? chatVO;
  UserVO? userVO;
  final FirebaseApi _api = FirebaseApi();
  File? image;
  File? audio;
  TextEditingController msgController = TextEditingController();
  bool isRecording = false;
  final record = AudioRecorder();

  //To check User is logged in user
  LoginDataVO? loginDataVO;

  LiveChatBloc() {
    print("CALL BLOC =================");
    getLogInUserData();

    chatId = GetStorage().read(kBoxKeyFirebaseUserId);

    //listenChat();
    userVO = _smileShopModel.getUserDataFromDatabase();
    debugPrint("UsreImage>>>>>${userVO?.profileImage}");
    safeNotifyListeners();
  }

  void getLogInUserData() async {
    loginDataVO = _smileShopModel.getLoginResponseFromDatabase();
    print("log in data vo ======================> $loginDataVO");
    safeNotifyListeners();
  }

  // void sendMsg() async {
  //   if (audio != null) {
  //     await _api.sendMessage(
  //         chatId: chatId,
  //         message: '',
  //         messageType: MessageType.voice,
  //         file: audio);
  //     audio = null;
  //     safeNotifyListeners();
  //   } else if (msgController.text.isNotEmpty || image != null) {
  //     await _api.sendMessage(
  //         chatId: chatId,
  //         message: msgController.text,
  //         messageType: image == null ? MessageType.text : MessageType.image,
  //         file: image);
  //     msgController.clear();
  //     image = null;
  //     safeNotifyListeners();
  //   }
  // }
  //
  // void listenChat() {
  //   _api.getChatById(chatId).listen(
  //     (event) {
  //       chatVO = event;
  //       safeNotifyListeners();
  //     },
  //   );
  // }

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

  // void onTapFloatingActionButton() async {
  //   await _api.sendMessage(
  //     senderId: "2",
  //     chatId: chatId,
  //     message: 'Hello From Admin',
  //     messageType: image == null ? MessageType.text : MessageType.image,
  //   );
  // }
  //
  // void completeRecordingAudio() async {
  //   if (!isRecording) {
  //     return;
  //   } else {
  //     isRecording = false;
  //     safeNotifyListeners();
  //     audio = File(await record.stop() ?? '');
  //     sendMsg();
  //     safeNotifyListeners();
  //   }
  // }

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
