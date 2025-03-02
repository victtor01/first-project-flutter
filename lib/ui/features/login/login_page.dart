import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pointsale/common/constants/api_constants.dart';
import 'package:mobile_pointsale/ui/components/button_gradient.dart';
import 'package:mobile_pointsale/ui/components/custom_input.dart';
import 'package:mobile_pointsale/ui/features/select_store/select_store_page.dart';
import 'package:mobile_pointsale/ui/features/sign_up/sign_up_page.dart';
import 'package:mobile_pointsale/utils/api.dart';
import 'package:mobile_pointsale/utils/navigation_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _loginForm() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      final String url = "${ApiConstants.apiURL}/auth";

      try {
        await ApiService.dio.post(
          url,
          options: Options(headers: {"Content-Type": "application/json"}),
          data: {"email": email, "password": password},
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SelectStorePage()),
        );
      } catch (e) {
        print(e);
      }
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
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "Seja bem vindo de volta!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      fontFamily: "saira",
                      color: Colors.black87.withAlpha((255 * 0.7).toInt()),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextInput(
                    controller: _emailController,
                    label: "YOUR EMAIL",
                    hintText: "JonhDoe@example.com",
                  ),
                  const SizedBox(height: 20),
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
                    destination: () => SignUpPage(),
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
