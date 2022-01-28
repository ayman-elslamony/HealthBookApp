//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import '../providers/auth_controller.dart';
//import 'package:provider/provider.dart';
//
//final _firestore = Firestore.instance;
//String _email;
//
//class ChatScreen extends StatefulWidget {
//  static const routeName = '/chat';
//  @override
//  _ChatScreenState createState() => _ChatScreenState();
//}
//
//class _ChatScreenState extends State<ChatScreen> {
//  final messageTextController = TextEditingController();
//  String messageText;
//  void getUserEmail(){
//    _email = Provider.of<Auth>(context,listen: false).email;
//  }
//
//
//  @override
//  void initState() {
//    super.initState();
//    getUserEmail();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        leading: IconButton(
//            icon: Icon(Icons.arrow_back_ios),
//            onPressed: () {
//              Navigator.of(context).pop();
//            }),
//        title: Text('Chat'),
//        centerTitle: true,
//        actions: <Widget>[
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 8.0),
//            child: InkWell(
//              onTap: () {},
//              child: Center(
//                child: Stack(
//                  children: <Widget>[
//                    Icon(
//                      Icons.notifications,
//                      size: 28,
//                    ),
//                    Positioned(
//                        right: 2.9,
//                        top: 2.8,
//                        child: Container(
//                          width: 11,
//                          height: 11,
//                          decoration: BoxDecoration(
//                              color: Colors.red,
//                              borderRadius: BorderRadius.circular(5)),
//                        ))
//                  ],
//                ),
//              ),
//            ),
//          )
//        ],
//      ),
//      body: SafeArea(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            MessagesStream(),
//            Container(
//              decoration: BoxDecoration(
//                border: Border(
//                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//                ),
//              ),
//              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Expanded(
//                    child: TextField(
//                      controller: messageTextController,
//                      onChanged: (value) {
//                        messageText = value;
//                      },
//                      decoration:InputDecoration(
//                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                        hintText: 'Type your message here...',
//                        border: InputBorder.none,
//                      ),
//                    ),
//                  ),
//                  FlatButton(
//                    onPressed: () {
//                      messageTextController.clear();
//                      _firestore.collection('messages').add({
//                        'text': messageText,
//                        'sender': _email,
//                      });
//                    },
//                    child: Text(
//                      'Send',
//                      style: TextStyle(
//                        color: Colors.lightBlueAccent,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 18.0,
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class MessagesStream extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: _firestore.collection('messages').snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return Center(
//            child: CircularProgressIndicator(
//              backgroundColor: Colors.lightBlueAccent,
//            ),
//          );
//        }
//        final messages = snapshot.data.documents.reversed;
//        List<MessageBubble> messageBubbles = [];
//        for (var message in messages) {
//          final messageText = message.data['text'];
//          final messageSender = message.data['sender'];
//
//          final currentUser = _email;
//
//          final messageBubble = MessageBubble(
//            sender: messageSender,
//            text: messageText,
//            isMe: currentUser == messageSender,
//          );
//
//          messageBubbles.add(messageBubble);
//        }
//        return Expanded(
//          child: ListView(
//            reverse: true,
//            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//            children: messageBubbles,
//          ),
//        );
//      },
//    );
//  }
//}
//
//class MessageBubble extends StatelessWidget {
//  MessageBubble({this.sender, this.text, this.isMe});
//
//  final String sender;
//  final String text;
//  final bool isMe;
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.all(10.0),
//      child: Column(
//        crossAxisAlignment:
//        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//        children: <Widget>[
//          Text(
//            sender,
//            style: TextStyle(
//              fontSize: 12.0,
//              color: Colors.black54,
//            ),
//          ),
//          Material(
//            borderRadius: isMe
//                ? BorderRadius.only(
//                topLeft: Radius.circular(30.0),
//                bottomLeft: Radius.circular(30.0),
//                bottomRight: Radius.circular(30.0))
//                : BorderRadius.only(
//              bottomLeft: Radius.circular(30.0),
//              bottomRight: Radius.circular(30.0),
//              topRight: Radius.circular(30.0),
//            ),
//            elevation: 5.0,
//            color: isMe ? Colors.lightBlueAccent : Colors.white,
//            child: Padding(
//              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//              child: Text(
//                text,
//                style: TextStyle(
//                  color: isMe ? Colors.white : Colors.black54,
//                  fontSize: 15.0,
//                ),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}