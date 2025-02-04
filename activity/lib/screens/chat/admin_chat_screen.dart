import 'package:flutter/material.dart';
import 'package:activity/models/message_model.dart';
import 'package:activity/widgets/title_text.dart';

class AdminChatScreen extends StatefulWidget {
  @override
  _AdminChatScreenState createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final TextEditingController _textController = TextEditingController();
  List<MessageModel> _messages = []; // Mesajları saklayacak liste

  // Kullanıcı mesajlarını admin paneline ekleme (gerçek uygulamada API çağrısı yapılacak)
  void _receiveMessage(String text) {
    MessageModel newMessage = MessageModel(
      text: text,
      isAdmin: false,
      createdAt: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, newMessage); // Yeni mesajı ekliyoruz
    });
  }

  // Admin mesajını gönderme
  void _sendMessage(String text) {
    MessageModel newMessage = MessageModel(
      text: text,
      isAdmin: true,
      createdAt: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, newMessage); // Yeni mesajı ekliyoruz
    });

    _textController
        .clear(); // Mesaj gönderildikten sonra text alanını temizliyoruz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleTextWidget(label: 'Admin Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (ctx, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isAdmin
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          message.isAdmin ? Colors.grey[300] : Colors.blue[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        if (value.trim().isNotEmpty) {
                          _sendMessage(value);
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      String text = _textController.text.trim();
                      if (text.isNotEmpty) {
                        _sendMessage(text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
