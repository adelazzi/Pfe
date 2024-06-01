import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  final int id1;
  final int id2;

  const ChatScreen({Key? key, required this.id1, required this.id2})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final url1 =
        'http://127.0.0.1:8000/message/getmassage/${widget.id1}/${widget.id2}/';
    final url2 =
        'http://127.0.0.1:8000/message/getmassage/${widget.id2}/${widget.id1}/';

    try {
      final response1 = await http.get(Uri.parse(url1));
      final response2 = await http.get(Uri.parse(url2));

      if (response1.statusCode == 200 && response2.statusCode == 200) {
        final List<dynamic> data1 = jsonDecode(response1.body);
        final List<dynamic> data2 = jsonDecode(response2.body);

        List<Map<String, dynamic>> allMessages = [];

        allMessages.addAll(data1.map((message) => {
              'text': message['textmessage'],
              'isMe': message['fromuser'] == widget.id1,
              'timestamp': DateTime.parse(message['timestamp']),
            }));

        allMessages.addAll(data2.map((message) => {
              'text': message['textmessage'],
              'isMe': message['fromuser'] == widget.id1,
              'timestamp': DateTime.parse(message['timestamp']),
            }));

        allMessages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

        setState(() {
          messages = allMessages;
        });
      } else {
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      throw Exception('Failed to load messages: $e');
    }
  }

  Future<void> createMessage(String textMessage) async {
    final url = 'http://127.0.0.1:8000/message/Create/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'fromuser': widget.id1,
          'touser': widget.id2,
          'textmessage': textMessage,
        }),
      );

      if (response.statusCode == 201) {
        // Message created successfully
        print('Message created successfully');
      } else {
        // Error creating message
        print('Failed to create message: ${response.body}');
      }
    } catch (e) {
      // Exception occurred
      print('Error creating message: $e');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.id2}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatMessageBubble(
                  message: messages[index]['text'],
                  isMe: messages[index]['isMe'],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if(messageController.text.isNotEmpty){
                      final text = messageController.text; // Get the text from the TextField
                      createMessage(text); // Call createMessage function with the text
                      messageController.clear();
                      fetchMessages();
                    }
                    
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatMessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}


















/*
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = []; // List to store sent messages
  TextEditingController messageController = TextEditingController(); // Controller for text field

  // Function to send a message
  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add(messageController.text);
        // Clear the text field after sending the message
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
