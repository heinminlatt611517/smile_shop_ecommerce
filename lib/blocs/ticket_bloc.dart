import 'package:flutter/material.dart';
import 'package:smile_shop/utils/colors.dart';

import '../data/vos/ticket_vo.dart';
import '../network/firebase_api.dart';

class TicketBloc extends ChangeNotifier {
  bool isDisposed = false;

  final FirebaseApi _api = FirebaseApi();

  List<TicketVo> ticketList = [];

  TicketBloc() {
    listenTickets();
  }

  void createAccount() async {
    //await _api.createUser(FIREBASE_USER);
  }

  void onTapCreateTicket(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      // To handle keyboard overflow for text fields
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom +
              20, // Adjust for keyboard
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Makes it only as tall as needed
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create a Ticket",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle:const TextStyle(color: Colors.black),
                enabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: kPrimaryColor, width: 1),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: kPrimaryColor, width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              cursorColor: kPrimaryColor,
              controller: descriptionController,
              decoration: InputDecoration(
                labelStyle:const TextStyle(color: Colors.black),
                labelText: "Description",
                focusedBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: kPrimaryColor, width: 1),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: kPrimaryColor, width: 1),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.black, width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3, // Allow for multi-line input
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                creatTicket(
                    context, titleController.text, descriptionController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF8800),
                // Primary color for button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(
                child: Text(
                  "Create Ticket",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void creatTicket(
      BuildContext context, String title, String description) async {
    Navigator.pop(context);
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title and Description cannot be empty!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    await _api.createTicket(title, description);
  }

  void listenTickets() {
    _api.getTicketsByUser().listen((tickets) {
      tickets.sort((a, b) {
        String updatedAtA = a.updatedAt ?? "";
        String updatedAtB = b.updatedAt ?? "";
        return updatedAtB.compareTo(updatedAtA);
      });
      ticketList = tickets;
      safeNotifyListeners();
    });
  }

  void safeNotifyListeners() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
