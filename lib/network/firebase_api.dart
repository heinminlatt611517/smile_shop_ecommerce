// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:smile_shop/utils/strings.dart';
//
// import '../data/dummy_data/dummy_data.dart';
// import '../data/vos/chat_vo.dart';
// import '../data/vos/firebase_user_vo.dart';
// import '../data/vos/message_vo.dart';
//
// enum MessageType { text, image, voice }
//
// class FirebaseApi {
//   static final FirebaseApi _singleton = FirebaseApi._internal();
//
//   factory FirebaseApi() {
//     return _singleton;
//   }
//
//   FirebaseApi._internal();
//
//   final _firebase = FirebaseFirestore.instance;
//   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
//
//   Future<void> createUser(FirebaseUserVo userVo) async {
//     CollectionReference users = _firebase.collection("users");
//     DocumentReference docRef = users.doc();
//
//     FirebaseUserVo(id: userVo.id, name: userVo.name, phone: userVo.phone);
//
//     await docRef.set(userVo.toJson());
//   }
//
//   Future<void> createChats(String userID) async {
//     CollectionReference chats = _firebase.collection("chats");
//
//     ///check user is already exist in fireStore
//     QuerySnapshot querySnapshot = await chats.where('userId', isEqualTo: userID).get();
//
//     if (querySnapshot.docs.isEmpty) {
//       debugPrint("Create a chats with new userID");
//       DocumentReference docRef = chats.doc();
//
//       ChatVo chatVO = ChatVo(
//         chatId: docRef.id,
//         title: '',
//         description: '',
//         userId: userID,
//         status: "open",
//         createdBy: FIREBASE_USER.name?.toString(),
//         assignedTo: null,
//         createdAt: DateTime.now().toString(),
//         updatedAt: DateTime.now().toString(),
//       );
//
//       await GetStorage().write(kBoxKeyFirebaseUserId, docRef.id);
//       await docRef.set(chatVO.toJson());
//     } else {
//       DocumentSnapshot chatDocument = querySnapshot.docs.first;
//       String chatId = chatDocument['chatId'];
//       await GetStorage().write(kBoxKeyFirebaseUserId,chatId);
//       debugPrint("Chat with this userID already exists.");
//     }
//   }
//
//
//   Stream<List<ChatVo>> getChatsByUser() {
//     CollectionReference chats = _firebase.collection("chats");
//
//     return chats
//         .where("createdBy", isEqualTo: FIREBASE_USER.id?.toString())
//         .snapshots()
//         .map(
//           (snapshot) => snapshot.docs
//               .map((doc) =>
//                   ChatVo.fromJson(doc.data() as Map<String, dynamic>))
//               .toList(),
//         );
//   }
//
//   Future<String?> uploadFile(File file) async {
//     try {
//       String userId = FIREBASE_USER.id?.toString() ?? "unknown";
//       final Reference ref = _firebaseStorage
//           .ref('uploads/$userId/${DateTime.now().millisecondsSinceEpoch}');
//       final UploadTask uploadTask = ref.putFile(file);
//       final TaskSnapshot snapshot = await uploadTask;
//       final String downloadUrl = await snapshot.ref.getDownloadURL();
//
//       print("File uploaded successfully. Download URL: $downloadUrl");
//       return downloadUrl;
//     } catch (e) {
//       print("Error uploading file: $e");
//       return null;
//     }
//   }
//
//   Future<void> sendMessage({
//     required String chatId,
//     required String message,
//     File? file,
//     String? senderId,
//     required MessageType messageType,
//   }) async {
//     CollectionReference chats = _firebase.collection("chats");
//     DocumentReference chatRef = chats.doc(chatId);
//
//     String? downloadUrl;
//
//     if (file != null) {
//       downloadUrl = await uploadFile(file);
//     }
//     print("DOWNLOAD URL ============> $downloadUrl");
//
//     MessageVo messageVo = MessageVo(
//       message: message,
//       messageType: messageType.toString().split('.').last,
//       senderId:senderId ?? FIREBASE_USER.id?.toString(),
//       sentAt: DateTime.now().toString(),
//       attachmentUrl: downloadUrl,
//     );
//
//     chatRef.update({
//       "messages": FieldValue.arrayUnion([messageVo.toJson()]),
//       "updatedAt": DateTime.now().toString(),
//     });
//   }
//
//   Stream<ChatVo> getChatById(String chatVO) {
//     CollectionReference tickets = _firebase.collection("chats");
//
//     return tickets.doc(chatVO).snapshots().map(
//           (snapshot) =>
//               ChatVo.fromJson(snapshot.data() as Map<String, dynamic>),
//         );
//   }
// }


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../data/dummy_data/dummy_data.dart';
import '../data/vos/firebase_user_vo.dart';
import '../data/vos/message_vo.dart';
import '../data/vos/ticket_vo.dart';

enum MessageType {
  text,
  image,
  voice
}

class FirebaseApi {
  static final FirebaseApi _singleton = FirebaseApi._internal();
  factory FirebaseApi() {
    return _singleton;
  }

  FirebaseApi._internal();
  final _firebase = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> createUser(FirebaseUserVo userVo) async {
    CollectionReference users = _firebase.collection("users");
    QuerySnapshot querySnapshot = await users.where('id', isEqualTo: userVo.id).get();

    if(querySnapshot.docs.isEmpty){
      await users.add(userVo.toJson());
      createTicket("", "",userVo.id.toString());
    }
  }

  Future<void> createTicket(String title, String description,String userID) async {
    CollectionReference tickets = _firebase.collection("tickets");
    DocumentReference docRef = tickets.doc();

    TicketVo ticketVo = TicketVo(
      ticketId: docRef.id,
      title: title,
      description: description,
      status: "open",
      createdBy: userID,
      assignedTo: null,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
    );

    await docRef.set(ticketVo.toJson());
  }



  Stream<List<TicketVo>> getTicketsByUser(String userId) {
    CollectionReference tickets = _firebase.collection("tickets");

    return tickets.where("createdBy", isEqualTo: userId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => TicketVo.fromJson(doc.data() as Map<String, dynamic>)).toList(),
    );
  }

  Future<String?> uploadFile(File file) async {
    //upload file to firebase storage and return the download url
    try {
      String userId = FIREBASE_USER.id?.toString() ?? "unknown";
      final Reference ref = _firebaseStorage.ref('uploads/$userId/${DateTime.now().millisecondsSinceEpoch}');
      final UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      print("File uploaded successfully. Download URL: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Error uploading file: $e");
      return null;
    }
  }

  Future<void> sendMessage({
    required String ticketId,
    required String message,
    File? file,
    required MessageType messageType,
  }) async {
    CollectionReference tickets = _firebase.collection("tickets");
    DocumentReference ticketRef = tickets.doc(ticketId);

    String? downloadUrl;

    if (file != null) {
      downloadUrl = await uploadFile(file);
    }
    print("DOWNLOAD URL ============> $downloadUrl");

    MessageVo messageVo = MessageVo(
      message: message,
      messageType: messageType.toString().split('.').last,
      senderId: FIREBASE_USER.id?.toString(),
      sentAt: DateTime.now().toString(),
      attachmentUrl: downloadUrl,
      isRead: false,
      isAdmin: false
    );

    ticketRef.update({
      "messages": FieldValue.arrayUnion([
        messageVo.toJson()
      ]),
      "updatedAt": DateTime.now().toString(),
    });
  }

  Stream<TicketVo> getTicketById(String ticketId) {
    CollectionReference tickets = _firebase.collection("tickets");

    return tickets.doc(ticketId).snapshots().map(
          (snapshot) => TicketVo.fromJson(snapshot.data() as Map<String, dynamic>),
    );
  }
}
