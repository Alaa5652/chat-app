import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/message_model.dart';

import '../constans/constans.dart';
import '../constans/message_received.dart'; // Import your MessageModel

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String id = 'Chat Screen';
  ScrollController _scrollController = ScrollController();

   CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagecollection);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot<MessageModel>>(
      stream: messages.orderBy(kcreatesdAt, descending: true).snapshots()?? ,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<MessageModel>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        List<MessageModel> messagesList = [];
        if (snapshot.hasData) {
          messagesList = snapshot.data!.docs.map((doc) {
            final data = doc.data();
            return MessageModel.fromJson(data); // Ensure your MessageModel.fromJson is correctly implemented
          }).toList();
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: kMaincolor,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(kLogo, height: 60),
                const Text('Chat'),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].useremail == email
                        ? MessageSended(
                      message: messagesList[index],
                    )
                        : MessageReceived(
                      message: messagesList[index],
                    );
                  },
                ),
              ),
              TextField(
                controller: controller,
                onSubmitted: (value) {
                  messages.add({
                    'message': value,
                    kcreatesdAt: DateTime.now(), // Use the correct constant
                    kUseremail: email,
                  });
                  controller.clear();
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                scrollPadding: const EdgeInsets.all(2),
                decoration: InputDecoration(
                  hintText: 'Send Massage',
                  suffixIcon: const Icon(Icons.send),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: kMaincolor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: kMaincolor)),
                ),
              ),
            ],
          ),
        );
      },
    )??Text('data');
  }
}
