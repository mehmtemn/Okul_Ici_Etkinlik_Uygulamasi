import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Eğer yeni değer boşsa, değiştirilmeden geri döndür.
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Yeni değerdeki metni böl ve ayı kontrol et.
    final parts = newValue.text.split('/');
    if (parts.isNotEmpty) {
      final month = int.tryParse(parts[0]);
      if (month != null && (month < 1 || month > 12)) {
        // Ay kısmı 1-12 aralığında değilse eski değeri döndür.
        return oldValue;
      }
    }
    return newValue;
  }
}

class OdemeScreen extends StatefulWidget {
  const OdemeScreen({super.key});

  @override
  State<OdemeScreen> createState() => _OdemeScreenState();
}

class _OdemeScreenState extends State<OdemeScreen> {
  final TextEditingController kartNoController = TextEditingController();
  final TextEditingController kullanmaTarihiController =
  TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  void _clearTextFields() {
    kartNoController.clear();
    kullanmaTarihiController.clear();
    cvvController.clear();
  }

  void _validateAndSubmit() {
    if (kartNoController.text.isEmpty ||
        kullanmaTarihiController.text.isEmpty ||
        cvvController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Uyarı'),
            content: Text('Lütfen tüm alanları doldurun.'),
            actions: <Widget>[
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (kartNoController.text.length != 16) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Uyarı'),
            content: Text('Kart numarası 16 haneli olmalıdır.'),
            actions: <Widget>[
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (cvvController.text.length != 3) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Uyarı'),
            content: Text('CVV/CVC 3 haneli olmalıdır.'),
            actions: <Widget>[
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ödeme Başarılı'),
            content: Text('Ödeme işlemi başarı ile gerçekleştirildi.'),
            actions: <Widget>[
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _clearTextFields(); // TextField'ları temizle
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ödeme"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Kart Numarası',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: kartNoController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength:
                    16, // Kart numarasının 16 haneli olmasını zorunlu kılar
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Kart numarasını girin',
                      counterText: '', // Karakter sayısını gizler
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Kullanma Tarihi',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: kullanmaTarihiController,
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d{0,2}\/?\d{0,2}$')),
                      MonthInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'MM/YY',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'CVV/CVC',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'CVV/CVC',
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: _validateAndSubmit,
                    child: Text("Öde"),
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