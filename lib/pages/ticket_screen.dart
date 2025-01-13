import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_shop/utils/colors.dart';
import 'package:smile_shop/utils/extensions.dart';
import '../blocs/ticket_bloc.dart';
import '../data/vos/ticket_vo.dart';
import 'chat_screen.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TicketBloc(),
      child: Consumer<TicketBloc>(
        builder: (context, bloc, child) => Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            forceMaterialTransparency: true,
            elevation: 0,
            title: const Text(
              "Live Chat",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              // IconButton(
              //     onPressed: () {
              //       bloc.createAccount();
              //     },
              //     icon: const Icon(Icons.person))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              bloc.onTapCreateTicket(context);
            },
            backgroundColor: const Color(0xffFF8800),
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: bloc.ticketList.length,
              itemBuilder: (context, index) {
                TicketVo ticket = bloc.ticketList[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(
                        )));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffFF8800), // Use brand color
                      borderRadius: BorderRadius.circular(12), // Smooth corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Subtle shadow for depth
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                ticket.title ?? "No Title",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis, // Prevent overflow
                              ),
                            ),
                            Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white.withOpacity(0.8), // Subtle icon
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8), 
                        Text(
                          ticket.description ?? "No Title",
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14 ,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis, // Prevent overflow
                        ),
                        const SizedBox(height: 8), // Space between title and info row
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  DateTime.parse(ticket.updatedAt ?? '').format(),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2), // Subtle background for status
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                ticket.status ?? "No Status",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
