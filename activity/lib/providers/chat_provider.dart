import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<Map<String, dynamic>> _messages = [
    {
      "text":
          "Hoşgeldiniz Lütfen bir seçenek seçin: \n1. Etkinlik hakkında \n2. Ödeme hakkında \n3. Diğer",
      "isAdmin": true
    },
  ];

  List<Map<String, dynamic>> get messages => _messages;

  void addMessage(String message, {bool isAdmin = false}) {
    _messages.add({"text": message, "isAdmin": isAdmin});
    notifyListeners();
  }

  void handleUserChoice(String choice) {
    if (choice == '1') {
      addMessage(
          "Etkinlik ile ilgili nasıl yardımcı olabiliriz? \n1. Tarih değişikliği \n2. İptal \n3. Yer bilgisi",
          isAdmin: true);
    } else if (choice == '2') {
      addMessage(
          "Ödeme ile ilgili nasıl yardımcı olabiliriz? \n1. Fatura \n2. İade \n3. Diğer",
          isAdmin: true);
    } else if (choice == '3') {
      addMessage("Lütfen detaylı bir şekilde sorununuzu anlatın.",
          isAdmin: true);
    } else {
      addMessage(
          "Geçersiz seçenek. Lütfen geçerli bir seçenek girin: \n1. Etkinlik hakkında \n2. Ödeme hakkında \n3. Diğer",
          isAdmin: true);
    }
  }

  void handleResponse(String response) {
    if (response.toLowerCase() == 'evet') {
      addMessage(
          "Lütfen bir seçenek seçin: \n1. Etkinlik hakkında \n2. Ödeme hakkında \n3. Diğer",
          isAdmin: true);
    } else if (response.toLowerCase() == 'hayır') {
      addMessage("İyi Günler dilerim", isAdmin: true);
    } else {
      addMessage(
          "Yanıtınız için teşekkür ederiz. Sorununuzu en kısa sürede çözmek için çalışıyoruz. Size başka bir konuda yardımcı olmamı ister misiniz? (Evet / Hayır)",
          isAdmin: true);
    }
  }

  void handleDetailedResponse(String detailedResponse) {
    addMessage(
        "Yanıtınız için teşekkür ederiz. Sorununuzu en kısa sürede çözmek için çalışıyoruz. Size başka bir konuda yardımcı olmamı ister misiniz? (Evet / Hayır)",
        isAdmin: true);
  }
}
