import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giuaky/pages/home.dart';
import 'package:giuaky/service/database.dart'; // Import class DatabaseMethods để sử dụng

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Hàm kiểm tra đăng nhập từ Firestore
  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    // Kiểm tra đăng nhập từ Firestore
    bool isValid = await DatabaseMethods().checkLoginAdmin(email, password);

    if (isValid) {
      // Nếu thông tin đăng nhập đúng, chuyển đến trang Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      // Nếu thông tin đăng nhập sai, hiện thông báo lỗi
      Fluttertoast.showToast(
        msg: "Thông tin đăng nhập không chính xác",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng Nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'User'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true, // Ẩn mật khẩu
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
