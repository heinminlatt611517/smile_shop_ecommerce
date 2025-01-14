import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class LogoutDialogView extends StatelessWidget {
  final Function onLogout;
  const LogoutDialogView({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(kMarginMedium2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kMarginMedium2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon to indicate logout action
            Container(
              padding: const EdgeInsets.all(kMarginMedium2),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Are you sure?",
              style: TextStyle(
                fontSize: kTextRegular2x,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Do you want to logout from the app?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: kTextRegular,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            // Logout and Cancel buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      onLogout();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Center(
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
