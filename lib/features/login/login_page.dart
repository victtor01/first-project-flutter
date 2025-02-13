import 'package:flutter/material.dart';
import 'package:test/components/button_gradient.dart';
import 'package:test/components/custom_input.dart';
import 'package:test/features/home/home_page.dart';
import 'package:test/utils/navigation_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _loginForm() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      print("$email + $password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    "Seja bem vindo de volta!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87.withAlpha((255 * 0.7).toInt()),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextInput(
                    controller: _emailController,
                    label: "YOUR EMAIL",
                    hintText: "JonhDoe@example.com",
                  ),
                  const SizedBox(height: 30),
                  CustomTextInput(
                    controller: _passwordController,
                    label: "YOUR PASSWORD",
                    hintText: "JonhDoe",
                  ),
                  const SizedBox(height: 30),
                  ButtonGradient(
                    buttonText: "Login",
                    height: 54,
                    fontSize: 23,
                    onPressed: () {
                      _loginForm();
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomLink(
                    primaryText: "Ainda não tem uma conta? ",
                    secondaryText: "SignUp",
                    destination: () => HomePage(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
