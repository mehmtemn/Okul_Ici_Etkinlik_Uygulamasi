import 'package:flutter/material.dart';
import 'package:activity/services/assets_manages.dart';
import 'package:activity/widgets/title_text.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isWaitingForUserChoice = true;
  bool _isWaitingForSubChoice = false;
  bool _isWaitingForDetailedResponse = false;
  bool _isConversationEnded = false; // Konuşma bitiş durumu

  @override
  void initState() {
    super.initState();
    _sendAdminOptions();
  }

  void _sendMessage(String text) {
    if (text.isEmpty || _isConversationEnded)
      return; // Konuşma bittiyse mesaj göndermesini engelle

    setState(() {
      _messages.add(Message(text: text, isUser: true));
      if (_isWaitingForUserChoice) {
        _handleUserChoice(text);
      } else if (_isWaitingForSubChoice) {
        _handleSubChoice(text);
      } else if (_isWaitingForDetailedResponse) {
        _handleDetailedResponse(text);
      }
    });

    _controller.clear();
    _scrollToBottom();
  }

  void _sendAdminOptions() {
    String adminOptions =
        "Lütfen bir seçenek seçin:\n1. Etkinlik hakkında\n2. Ödeme hakkında\n3. Diğer";

    setState(() {
      _messages.add(Message(text: adminOptions, isUser: false));
    });
    _scrollToBottom();
  }

  void _handleUserChoice(String userMessage) {
    if (userMessage.toLowerCase().contains("1")) {
      _isWaitingForUserChoice = false;
      _isWaitingForSubChoice = true;
      _sendAdminResponse("etkinlik");
    } else if (userMessage.toLowerCase().contains("2")) {
      _isWaitingForUserChoice = false;
      _isWaitingForSubChoice = true;
      _sendAdminResponse("ödeme");
    } else if (userMessage.toLowerCase().contains("3")) {
      _isWaitingForUserChoice = false;
      _isWaitingForDetailedResponse = true;
      _sendAdminResponse("diğer");
    } else {
      // Geçersiz seçenek durumunda tekrar seçenekleri göster
      _sendAdminOptions();
    }
  }

  void _handleSubChoice(String userMessage) {
    if (userMessage.toLowerCase().contains("1") ||
        userMessage.toLowerCase().contains("2") ||
        userMessage.toLowerCase().contains("3")) {
      _isWaitingForSubChoice = false;
      _isWaitingForDetailedResponse = true;
      _sendAdminDetailedRequest();
    } else {
      // Geçersiz alt seçenek durumunda tekrar seçenekleri göster
      _sendAdminResponse("geriDön");
    }
  }

  void _sendAdminResponse(String category) {
    String adminResponse = "";

    switch (category) {
      case "etkinlik":
        adminResponse =
            "Etkinlik ile ilgili nasıl yardımcı olabiliriz?\n1. Tarih değişikliği\n2. İptal\n3. Yer bilgisi";
        break;
      case "ödeme":
        adminResponse =
            "Ödeme ile ilgili nasıl yardımcı olabiliriz?\n1. Fatura\n2. İade\n3. Diğer";
        break;
      case "diğer":
        adminResponse = "Lütfen detaylı bir şekilde sorununuzu anlatın.";
        break;
      case "geriDön":
        adminResponse = "Lütfen geçerli bir seçenek girin.";
        break;
      default:
        adminResponse =
            "Yanıtınız için teşekkür ederiz. Sorununuzu en kısa sürede çözmek için çalışıyoruz.";
        break;
    }

    setState(() {
      _messages.add(Message(text: adminResponse, isUser: false));
    });
    _scrollToBottom();
  }

  void _sendAdminDetailedRequest() {
    setState(() {
      _messages.add(Message(
          text: "Lütfen detaylı bir şekilde sorununuzu anlatın.",
          isUser: false));
    });
    _scrollToBottom();
  }

  void _handleDetailedResponse(String userMessage) {
    setState(() {
      _messages.add(Message(
          text:
              "Yanıtınız için teşekkür ederiz. Sorununuzu en kısa sürede çözmek için çalışıyoruz.",
          isUser: false));
      _isWaitingForDetailedResponse = false;
      _isConversationEnded = true; // Konuşma sona erdi
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleTextWidget(
          label: 'Chat with Admin',
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsManager.chat), // Arka plan resminiz
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: message.isUser ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!_isConversationEnded) // Konuşma sona erdiyse yazı alanını gizle
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => _sendMessage(_controller.text),
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

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}
