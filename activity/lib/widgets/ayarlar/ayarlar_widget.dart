import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AyarlarWidget extends StatefulWidget {
  final String image;
  final String baslik;

  AyarlarWidget({required this.image, required this.baslik});

  @override
  State<AyarlarWidget> createState() => _AyarlarWidgetState();
}

class _AyarlarWidgetState extends State<AyarlarWidget> {
  bool status = false;

  Future<void> _showConfirmationDialog(bool newValue) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Dialog'un dışına tıklanarak kapanmasını engelle
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emin misiniz?'),
          content: Text('Bu işlemi onaylamak istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
            ),
            TextButton(
              child: Text('Evet'),
              onPressed: () {
                setState(() {
                  status = newValue; // Switch'in değerini değiştir
                });
                Navigator.of(context).pop(); // Dialog'u kapat
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Expanded to full width
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 16.0), // Add some padding if needed
      child: Row(
        children: [
          Image.asset(
            widget.image,
            fit: BoxFit.fill,
            width: 50,
            height: 50,
          ),
          SizedBox(width: 10), // Add some space between image and text
          Text(
            widget.baslik,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Spacer(), // This will take the remaining space
          CupertinoSwitch(
            value: status,
            onChanged: (value) {
              _showConfirmationDialog(value); // Onay diyalogunu göster
            },
          ),
        ],
      ),
    );
  }
}
