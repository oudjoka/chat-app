import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discussion/constants.dart';
import 'package:discussion/models/message.dart';
import 'package:discussion/widgets/chat_buble.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  final _controller = ScrollController();
//FirebaseFirestore firestore = FirebaseFirestore.instance;
 final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
 final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                const  Text(
                    '  ChaTTy',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBuble(
                              message: messagesList[index],
                            )
                          : ChatBubleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      if (data.isNotEmpty) {
                        messages.add({
                          kCreatedAt: DateTime.now(),
                          kId: email,
                          kMessage: data,
                        });
                        controller.clear();
                        _controller.animateTo(
                          0, //position
                          duration:const Duration(microseconds: 500),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Send message',
                      hintStyle:const TextStyle(
                        color: Colors.grey,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          String message =
                              controller.text.trim(); // Get text from TextField
                          if (message.isNotEmpty) {
                            // Ensure message is not empty
                            messages.add({
                              kCreatedAt: DateTime.now(),
                              kId: email,
                              kMessage: message,
                            });

                            controller.clear(); // Clear input field

                            _controller.animateTo(
                              0, // Scroll to bottom
                              duration:const Duration(
                                  milliseconds:
                                      500), // Use milliseconds instead of microseconds
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        child:const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:const BorderSide(
                            color: kPrimaryColor,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:const BorderSide(
                            color: kPrimaryColor,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:const BorderSide(
                            color: kPrimaryColor,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
