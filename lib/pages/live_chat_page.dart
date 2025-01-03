import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/utils/extensions.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../blocs/chat_bloc.dart';
import '../data/dummy_data/dummy_data.dart';
import '../data/vos/message_vo.dart';
import '../network/firebase_api.dart';

class LiveChatPage extends StatelessWidget {
  final String? ticketId;
  const LiveChatPage({super.key,this.ticketId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatBloc(ticketId ?? ""),
      child: Consumer<ChatBloc>(
        builder: (context, bloc, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Chat"),
            forceMaterialTransparency: true,
            scrolledUnderElevation: 0,
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: bloc.ticket?.messages?.length ?? 0,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemBuilder: (context, index) {
                        int reversedIndex = (bloc.ticket?.messages?.length ?? 0) - 1 - index;
                        MessageVo message = bloc.ticket!.messages?[reversedIndex] ?? MessageVo();
                        return ChatBubble(
                          messageVo: message,
                        );
                      },
                    ),
                  ),
                  ChatInputField(
                    onSend: () {
                      bloc.sendMsg();
                    },
                    imageFile: bloc.image,
                    audioFile: bloc.audio,
                    textController: bloc.msgController,
                    onTapAddImage: () {
                      bloc.pickImage();
                    },
                    onTapAddAudio: () {
                      bloc.startRecordingAudio();
                    },
                  ),
                ],
              ),
              if (bloc.isRecording)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.mic, color: Colors.white, size: 50),
                        const Text(
                          "Recording...",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () {
                              bloc.completeRecordingAudio();
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text(
                              "Complete",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            )),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () {
                              bloc.cancelRecordingAudio();
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ))
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final MessageVo messageVo;

  const ChatBubble({
    super.key,
    required this.messageVo,
  });

  @override
  Widget build(BuildContext context) {
    bool isSender = messageVo.senderId == FIREBASE_USER.id?.toString(); // Replace with actual senderId

    if (messageVo.messageType == MessageType.voice.name) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender)
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"), // Dummy profile image
            ),
          if (!isSender) const SizedBox(width: 8),
          Column(
            crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7, // 70% of screen
                ),
                decoration: BoxDecoration(
                  color: isSender ? const Color(0xffFF8800) : const Color(0xffFF8800).withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(12),
                    bottomRight: const Radius.circular(12),
                    topLeft: isSender ? const Radius.circular(12) : const Radius.circular(0),
                    topRight: isSender ? const Radius.circular(0) : const Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    // Audio player
                    VoiceMessageView(
                      controller: VoiceController(
                        audioSrc: messageVo.attachmentUrl ?? "",
                        maxDuration: const Duration(minutes: 15),
                        isFile: false,
                        onComplete: () {},
                        onPause: () {},
                        onPlaying: () {},
                        cacheKey: messageVo.attachmentUrl,
                      ),
                      backgroundColor: const Color(0xffFF8800),
                      circlesColor: Colors.white,
                      activeSliderColor: Colors.white,
                      innerPadding: 0,
                      circlesTextStyle:const TextStyle(color: Colors.black),
                      playIcon:const Icon(Icons.play_arrow, color: Color(0xffFF8800)),
                      pauseIcon:const Icon(Icons.pause, color: Color(0xffFF8800)),
                      playPauseButtonLoadingColor:const Color(0xffFF8800),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  DateTime.parse(messageVo.sentAt ?? "").format(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          if (isSender) const SizedBox(width: 8),
          if (isSender)
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"), // Dummy profile image
            ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isSender)
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("https://via.placeholder.com/150"), // Dummy profile image
          ),
        if (!isSender) const SizedBox(width: 8),
        Column(
          crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7, // 70% of screen
              ),
              decoration: BoxDecoration(
                color: isSender ? const Color(0xffFF8800) : const Color(0xffFF8800).withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                  topLeft: isSender ? const Radius.circular(12) : const Radius.circular(0),
                  topRight: isSender ? const Radius.circular(0) : const Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Message text
                  if (messageVo.message != null)
                    Text(
                      messageVo.message!,
                      style: TextStyle(
                        color: isSender ? Colors.white : Colors.black,
                      ),
                    ),

                  // Image (if available)
                  if (messageVo.attachmentUrl != null && messageVo.messageType == MessageType.image.name)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          messageVo.attachmentUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                DateTime.parse(messageVo.sentAt ?? "").format(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        if (isSender) const SizedBox(width: 8),
        if (isSender)
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("https://via.placeholder.com/150"), // Dummy profile image
          ),
      ],
    );
  }
}

class ChatInputField extends StatelessWidget {
  final Function onSend;
  final File? imageFile;
  final File? audioFile;
  final TextEditingController textController;
  final Function onTapAddImage;
  final Function onTapAddAudio;

  const ChatInputField({
    super.key,
    required this.onSend,
    required this.imageFile,
    required this.audioFile,
    required this.textController,
    required this.onTapAddImage,
    required this.onTapAddAudio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imageFile != null)
          Container(
              margin: const EdgeInsets.all(8.0),
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffFF8800),
              ),
              child: Image.file(
                imageFile!,
                fit: BoxFit.contain,
              )),
        Container(
          decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
          height: 40,
          margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.mic, color: Color(0xffFF8800)),
                onPressed: () {
                  onTapAddAudio();
                },
              ),
              IconButton(
                icon: const Icon(Icons.photo, color: Color(0xffFF8800)),
                onPressed: () {
                  onTapAddImage();
                },
              ),
              Expanded(
                child: TextField(
                  controller: textController,
                  style: const TextStyle(fontSize: 12),
                  decoration: const InputDecoration(
                    hintText: "Send a message",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 8),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  onSend();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(color: Color(0xffFF8800), shape: BoxShape.circle),
                  child: const Icon(Icons.send_outlined, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
