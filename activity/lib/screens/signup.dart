import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:activity/screens/login.dart'; // LoginScreen ekranını dahil edin
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _surnameController =
      TextEditingController(); // Kullanıcı soyadı için controller
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController =
      TextEditingController(); // Telefon numarası için controller

  bool _passwordVisible = false; // Şifre görünürlüğü için değişken

  @override
  void dispose() {
    _usernameController.dispose();
    _surnameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = {
        "name": _usernameController.text,
        "surname": _surnameController.text,
        "phone": _phoneController.text,
        "password": _passwordController.text,
        "email": _emailController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(
              'https://localhost:7227/api/UserSign/Create'), // API URL'i Ekleme Kısmı
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(user),
        );

        // Gelen yanıtı kontrol edelim
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}'); // Gelen Veriyi Yazdırma

        if (response.statusCode == 200) {
          // Eğer yanıt JSON ise, decode etmeye çalış
          final responseData = jsonDecode(response.body);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          // Yanıt başarılı değilse, hata mesajı yazdır
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Kayıt başarısız: ${response.body}')),
          );
        }
      } catch (error) {
        // Hata durumunda mesaj yazdır
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bir hata oluştu: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Üye Ol'),
        backgroundColor: Colors.black, // Siyah arka plan
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Beyaz arka plan
                borderRadius: BorderRadius.circular(12), // Köşeleri yuvarlat
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Kullanıcı adı
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Kullanıcı Adı',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200], // Açık gri arka plan
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kullanıcı adı boş olamaz';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Kullanıcı soyadı
                      TextFormField(
                        controller: _surnameController,
                        decoration: InputDecoration(
                          labelText: 'Kullanıcı Soyadı',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200], // Açık gri arka plan
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kullanıcı soyadı boş olamaz';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Şifre alanı
                      TextFormField(
                        controller: _passwordController,
                        obscureText:
                            !_passwordVisible, // Şifre görünürlüğü kontrolü
                        decoration: InputDecoration(
                          labelText: 'Şifre',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200], // Açık gri arka plan
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Şifre boş olamaz';
                          }
                          if (value.length < 6) {
                            return 'Şifre en az 6 karakter olmalıdır';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Şifre tekrar alanı
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Şifre Tekrar',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200], // Açık gri arka plan
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Şifreler eşleşmiyor';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // E-posta alanı
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-posta',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200], // Açık gri arka plan
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'E-posta boş olamaz';
                          }
                          if (!RegExp(
                                  r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                              .hasMatch(value)) {
                            return 'Geçerli bir e-posta girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Telefon numarası alanı
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Telefon Numarası',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200], // Açık gri arka plan
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Telefon numarası boş olamaz';
                          }
                          if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                            return 'Geçerli bir telefon numarası girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Üye ol butonu
                      ElevatedButton(
                        onPressed: () async {
                          print("Buttona tıklandı");
                          await _register();
                        },
                        child: const Text('Üye Ol'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // Siyah buton
                          foregroundColor: Colors.white, // Beyaz metin
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Giriş yap butonu
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Zaten bir hesabın var mı? '),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Giriş Yap',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black, // Siyah metin
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
