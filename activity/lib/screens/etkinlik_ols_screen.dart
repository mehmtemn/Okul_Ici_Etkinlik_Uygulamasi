import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
// import 'package:activity/models/product_model.dart';
import 'package:activity/models/event_model.dart';
import 'package:http/http.dart' as http; // HTTP isteği için gerekli
import 'dart:convert'; // JSON kodlama ve kod çözme için
import 'dart:io';
import 'package:flutter/services.dart';

class EtkinlikOlusScreen extends StatefulWidget {
  @override
  _EtkinlikOlusScreenState createState() => _EtkinlikOlusScreenState();
}

class _EtkinlikOlusScreenState extends State<EtkinlikOlusScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime _date = DateTime.now();
  String _description = '';
  double _price = 0.0;
  String _imageUrl = '';
  File? _imageFile;
  // TimeOfDay _time = TimeOfDay.now();
  String _amount = '';
  final ImagePicker _picker = ImagePicker();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newEvent = EventModel(
          name: _name,
          price: _price.toString(),
          date: _date.toIso8601String(),
          description: _description,
          image: _imageUrl,
          amount: _amount);

      bool success = await _createEvent(newEvent);

      if (success) {
        print("Ürün başarıyla oluşturuldu!");
        _formKey.currentState?.reset(); // Formu sıfırla
        setState(() {
          _imageFile = null; // Seçilen resmi sıfırla
          _imageUrl = ''; // URL'yi sıfırla
          _name = '';
          _date = DateTime.now();
          _description = '';
          _price = 0.0;
          _amount = '';
        });
        // Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Etkinlik başarıyla oluşturuldu.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5);
      } else {
        print("Ürün oluşturulurken bir hata oluştu.");
      }
    }
  }

  Future<bool> _createEvent(EventModel event) async {
    const url = 'http://localhost:5068/api/Etkinlik/Create';

    print(json.encode(event.toJson()));
    print(event.name);
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(event.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      print('Failed to create product: ${response.body}');
      return false;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrl = '';
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeriden Seç'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Kameradan Çek'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('URL ile Ekle'),
              onTap: () {
                Navigator.of(context).pop();
                _showUrlDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showUrlDialog() {
    TextEditingController urlController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resim URL\'si Ekle'),
        content: TextField(
          controller: urlController,
          decoration: InputDecoration(hintText: 'URL girin'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                _imageUrl = urlController.text;
                _imageFile = null;
              });
              Navigator.of(context).pop();
            },
            child: Text('Ekle'),
          ),
        ],
      ),
    );
  }

  /*Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (pickedTime != null && pickedTime != _time) {
      setState(() {
        _time = pickedTime;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Etkinlik Oluştur"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextField(
                label: 'Etkinlik Adı',
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bir ad girin';
                  }
                  return null;
                },
              ),
              _buildDateField(
                label: 'Tarih',
                onDateSelected: (pickedDate) {
                  setState(() {
                    _date = pickedDate;
                  });
                },
              ),
              _buildTextField(
                label: 'Açıklama',
                maxLines: 3,
                onSaved: (value) => _description = value!,
              ),
              _buildTextField(
                label: 'Fiyat',
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value!),
                validator: (value) {
                  if (value!.isEmpty || double.tryParse(value) == null) {
                    return 'Lütfen geçerli bir fiyat girin';
                  }
                  return null;
                },
              ),
              _buildImagePicker(context),
              /*_buildTimeField(
                label: 'Saat',
                onTimeSelected: _selectTime,
              ),*/
              _buildTextField(
                label: 'Miktar',
                onSaved: (value) => _amount = value!,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Kırmızı buton rengi
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Oluştur',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueGrey), // Etiket rengi
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.blueGrey, // Sınır rengi
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.blueGrey, // Odaklanmış sınır rengi
              width: 2,
            ),
          ),
        ),
        onSaved: onSaved,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(
              "[a-zA-Z0-9ğüşıöçĞÜŞİÖÇ.,@#\$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?~`\\s]")), // İzin verilen karakterler
        ],
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: _date,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            onDateSelected(pickedDate);
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.blueGrey), // Etiket rengi
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Sınır rengi
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Odaklanmış sınır rengi
                  width: 2,
                ),
              ),
            ),
            controller: TextEditingController(
              text: "${_date.toLocal()}".split(' ')[0],
            ),
            onSaved: (value) => _date = DateTime.parse(value!),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeField({
    required String label,
    required VoidCallback onTimeSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: onTimeSelected,
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.blueGrey), // Etiket rengi
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Sınır rengi
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blueGrey, // Odaklanmış sınır rengi
                  width: 2,
                ),
              ),
            ),
            controller: TextEditingController(
                // text: _time.format(context),
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_imageFile != null)
          Image.file(
            _imageFile!,
            height: 150,
            width: 150,
          )
        else if (_imageUrl.isNotEmpty)
          Image.network(
            _imageUrl,
            height: 150,
            width: 150,
          )
        else
          Text('Resim seçilmedi'),
        ElevatedButton(
          onPressed: () => _showImageSourceActionSheet(context),
          child: Text('Resim Seç'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey, // Buton rengi
          ),
        ),
      ],
    );
  }
}
