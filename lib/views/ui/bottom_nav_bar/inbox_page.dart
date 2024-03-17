import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../controllers/chat_provider.dart';
import '../../../models/response/chats/get_chat_res_model.dart';
import '../../common/reuseable_text_widget.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title:ReuseableText(text :  "Messages", style: roundFont(22, darkHeading, FontWeight.bold)),
),
      body: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
          chatNotifier.getChat();
          chatNotifier.getPrefs();
          return FutureBuilder<List<GetChats>>(
            future: chatNotifier.chats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(child: Text("No Chats available"));
              } else {
                var chatList = snapshot.data;
                return ListView.builder(
                  itemCount: chatList!.length,
                  itemBuilder: (context, index) {
                    final chat = chatList[
                    index]; // this will return the data of chat which contain two users, first sender, and 2nd receiver
                    // If I am using app then I don't want myself(sender) on the chatList, but the receiver
                    // print(chat.users[0].userName);
                    // print(chat.users[1].userName);
                    var user = chat.users.where((user) =>
                    user.id !=
                        chatNotifier
                            .userId); // this will return the user data of where user Id is not equal to the Id which is stored in the shared preference
                    // print(user.first.userName);

                    return GestureDetector(
                      onTap: () {
                        // Get.to(()=>IndividualChatPage(id: chat.id, title: user.first.userName,
                        // users: [chat.users[0].id, chat.users[1].id],));

                        Get.to(()=>ChatScreen(id: chat.chatName, title: user.first.firstName, users: [chat.users[0].id, chat.users[1].id], ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: darkHeading),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        margin: const EdgeInsets.all(5),
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          leading:  CircleAvatar(
                            backgroundColor: Colors.orangeAccent,
                            backgroundImage: user.first.profile.isNotEmpty ?  NetworkImage(user.first.profile) : null,
                          ),
                          title: ReuseableText(
                            text: user.first.firstName,
                            style: roundFont(20, Colors.black, FontWeight.bold),
                          ),
                          subtitle: ReuseableText(
                            text: user.first.phoneNumber,
                            style:
                            appStyle(16, Colors.black45, FontWeight.normal),
                          ),
                          trailing: ReuseableText(
                            text: chatNotifier.msgTime(chat.updatedAt.toString()),
                            style:
                            appStyle(16, Colors.black45, FontWeight.normal),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
