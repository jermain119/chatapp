// @dart=2.8

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/constants.dart';
final firestore = FirebaseFirestore.instance;
User loggedinuser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  String messageText;

  void getCurrentUser() async {
    try {
      if (_auth != null) {
        loggedinuser = _auth.currentUser;
        print(loggedinuser.email);
      }
    } catch (e) {
      print(e);
    }
    // _auth.getRedirectResult()
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageTextController.clear();
                      firestore.collection("messages").add({
                        "text": messageText,
                        // grabs id by email
                        "sender": loggedinuser.email,
                      }).whenComplete(() => print("comleted"));
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final messages = snapshot.data.docs.reversed;
        List<Messagebubble> messagesBubbles = [];
        for (var message in messages) {
          final messageSender = message["sender"];
          final messageText = message["text"];
         

          final currentUser = loggedinuser.email;

          final messageBubble = Messagebubble(
              sender: messageSender,
              text: messageText,
              isME: currentUser == messageSender);
          messagesBubbles.add(messageBubble);
          messagesBubbles .sort((a, b) => b.toString().compareTo(a.toString()));
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            children: messagesBubbles,
          ),
        );
      },
    );
  }
}

class Messagebubble extends StatelessWidget {
  Messagebubble({this.sender, this.text, this.isME, });
  final String sender;
  final String text;
  final bool isME;
   


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender ?? '',
            // email sender id styling
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Material(
            shadowColor: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                30.0,
              ),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isME ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text ?? '',
                style: TextStyle(
                  color: isME ? Colors.white : Colors.lightBlue,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
