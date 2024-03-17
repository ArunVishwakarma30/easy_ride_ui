import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../controllers/chat_provider.dart';
import '../../models/request/chat/send_msgs_req.dart';
import '../../models/response/chats/received_msgs_res.dart';
import '../../services/config.dart';
import '../../services/helper/messaging_helper.dart';
import '../common/height_spacer.dart';
import '../common/reuseable_text_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key, required this.id, required this.title, required this.users})
      : super(key: key);
  final String? id;
  final String? title;
  final List? users;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String senderId;
  IO.Socket? socket;
  int offset = 1;
  late Future<List<ReceivedMessage>> msgList;
  late TextEditingController _controller;
  List<ReceivedMessage> message = [];
  String receiverId = '';
  final ScrollController _scrollController = ScrollController();

  void connect() {
    var notifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io(Config.apiUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    notifier.getPrefs();
    socket!.emit('setup', notifier.userId);
    socket!.connect();
    socket!.onConnect(
      (_) {
        print("Connected to socket");

        // socket.on means we are receiving an event
        // socket.emmit means we are sending an event



        socket!.on('message recieved', (newMessgeRecieved) {
          sendStopTypingEvent(widget.id!);
          ReceivedMessage receivedMessage =
              ReceivedMessage.fromJson(newMessgeRecieved);

          if (receivedMessage.sender.id != notifier.userId) {
            setState(() {
              message.insert(0, receivedMessage);
            });
          }
        });
      },
    );
  }

  void sendMessage(String content, String chatId, String receiver, String senderId) {
    SendMessage model = SendMessage(
        content: content,
        chatId: chatId,
        senderId: senderId,
        receiver: receiver);
    MessagingHelper.sendMessage(model).then((response) {
      var emmission = response[2];
      socket!.emit("new message", (emmission));
      sendStopTypingEvent(widget.id!);
      setState(() {
        _controller.clear();
        message.insert(0, response[1]);
      });
    });
  }

  void sendTypingEvent(String roomId) {
    socket!.emit('typing', roomId);
  }

  void sendStopTypingEvent(String roomId) {
    socket!.emit('typing', roomId);
  }

  void joinChats() {
    socket!.emit(
        'join chat',
        widget
            .id); // we are connecting to one common room in order to chat with user, and the room Id will be our chatID
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages(offset);
    _controller = TextEditingController();
    connect();
    joinChats();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void getMessages(int offset) {
    msgList = MessagingHelper.getMessages(widget.id!, offset);
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          print("<<><><><Loading><><><>>");
          if (message.length > 12) {
            getMessages(offset++);
          }
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        receiverId =
            widget.users!.firstWhere((userId) => userId != chatNotifier.userId);

        print("receiverId : $receiverId");
        senderId = chatNotifier.userId!;
        return Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title!),
                  chatNotifier.typing
                      ? Text(
                          "typing...",
                          style: appStyle(12, Colors.green, FontWeight.normal),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: chatNotifier.online.contains(receiverId)
                      ? ReuseableText(
                          text: "Online",
                          style: appStyle(14, Colors.green, FontWeight.normal))
                      : SizedBox.shrink(),
                )
              ],
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<ReceivedMessage>>(
                      future: msgList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text("You do not have messages"));
                        } else {
                          var chatList = snapshot.data;
                          final conversationList = message + chatList!;
                          print("chatList $chatList");
                          return ListView.builder(
                            reverse: true,
                            controller: _scrollController,
                            itemCount: conversationList!.length,
                            itemBuilder: (context, index) {
                              final chat = conversationList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 12),
                                child: Column(
                                  children: [
                                    ReuseableText(
                                        text: chatNotifier
                                            .msgTime(chat.updatedAt.toString()),
                                        style: appStyle(12, Colors.black45,
                                            FontWeight.normal)),
                                    const HeightSpacer(size: 10),
                                    ChatBubble(
                                      alignment:
                                          chat.sender.id == chatNotifier.userId
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      backGroundColor:
                                          chat.sender.id == chatNotifier.userId
                                              ? Colors.orange
                                              : Color(loginPageColor.value),
                                      elevation: 0,
                                      clipper: ChatBubbleClipper4(
                                        radius: 8,
                                        type: chat.sender.id ==
                                                chatNotifier.userId
                                            ? BubbleType.sendBubble
                                            : BubbleType.receiverBubble,
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                                        ),
                                        child: ReuseableText(
                                          text: chat.content,
                                          style: appStyle(
                                              16,
                                              Colors.white,
                                              FontWeight.normal),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.bottomCenter,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      cursorColor: Color(darkHeading.value),
                      style: roundFont(16, Colors.black, FontWeight.normal),
                      decoration: InputDecoration(
                          hintText: "Type your message here",
                          isDense: true,
                          contentPadding: EdgeInsets.all(6),
                          filled: true,
                          fillColor: Color(lightBorder.value),
                          suffixIcon: GestureDetector(
                            onTap: () {},
                            child: IconButton(
                              icon: const Icon(
                                Icons.send,
                                size: 24,
                              ),
                              onPressed: () {
                                print("Prssed");
                                if(_controller.text.toString().trim().isNotEmpty) {
                                  String content = _controller.text.toString();
                                  _controller.text = "";
                                  sendMessage(content, widget.id!, receiverId,
                                      senderId);
                                }
                              },
                            ),
                          )),
                      controller: _controller,
                    ),
                  )
                ],
              ),
            )));
      },
    );
  }
}
