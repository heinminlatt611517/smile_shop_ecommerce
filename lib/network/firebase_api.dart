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

    await users.add(userVo.toJson());
  }

  Future<void> createTicket(String title, String description) async {
    CollectionReference tickets = _firebase.collection("tickets");
    DocumentReference docRef = tickets.doc();

    TicketVo ticketVo = TicketVo(
      ticketId: docRef.id,
      title: title,
      description: description,
      status: "open",
      createdBy: FIREBASE_USER.id?.toString(),
      assignedTo: null,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
    );

    await docRef.set(ticketVo.toJson());
  }



  Stream<List<TicketVo>> getTicketsByUser() {
    CollectionReference tickets = _firebase.collection("tickets");

    return tickets.where("createdBy", isEqualTo: FIREBASE_USER.id?.toString()).snapshots().map(
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
