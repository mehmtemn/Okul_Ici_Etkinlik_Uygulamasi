import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:activity/constans/validator.dart';
import 'package:activity/models/users_model.dart';
import 'package:activity/root_screen.dart';
import 'package:activity/screens/signup.dart';
import 'package:activity/services/assets_manages.dart';
import 'package:activity/widgets/title_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  final Dio dio = Dio();
  final String baseUrl = 'http://localhost:5068';

  Future<UsersModel?> fetchUserData(String email, String password) async {
    try {
      Response response = await dio.post(
        '$baseUrl/api/UserSign/Login',
        data: {'email': email, 'password': password},
      );

      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return UsersModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (title == 'Kayıt Olun')
              TextButton(
                child: Text('Kayıt Ol'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Şifremi Unuttum'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('6 haneli doğrulama kodu gönderilecek.'),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Doğrulama Kodu'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Gönder'),
              onPressed: () {
                // Doğrulama kodu gönderme işlemi burada yapılacak
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[300]!], // Beyaz arka plan
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),
                  Image.asset(
                    AssetsManager.tiket2,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: size.height * 0.05),
                  Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Colors.grey[50], // Beyaz kart
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'E-posta',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
                                fillColor: Colors.white, // Beyaz form alanı
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              validator: MyValidators.EmailValidator,
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                labelText: 'Şifre',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: MyValidators.PasswordValidator,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _showForgotPasswordDialog();
                                  },
                                  child: Text(
                                    'Şifremi Unuttum',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      UsersModel? user = await fetchUserData(
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                      if (user != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RootScreen(),
                                          ),
                                        );
                                      } else {
                                        _showAlertDialog(
                                          'Kayıt Olun',
                                          'Böyle bir kullanıcı bulunamadı. Lütfen kayıt olun.',
                                        );
                                      }
                                    }
                                  },
                                  child: TitleTextWidget(
                                    label: 'Giriş Yap',
                                    color: Colors.white,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 40,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()),
                                );
                              },
                              child: Text(
                                'Üye Ol',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
