import 'package:flutter/material.dart';
import 'package:test/ui/components/button_gradient.dart';
import 'package:test/ui/components/custom_input.dart';
import 'package:test/ui/features/login/login_page.dart';
import 'package:test/utils/navigation_utils.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100, left: 30, right: 30),
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centraliza verticalmente
            mainAxisSize: MainAxisSize.min, // Evita ocupar todo o espaço
            children: [
              const SizedBox(height: 40),
              Text(
                "Olá! é um prazer ter você conosco!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87.withAlpha((255 * 0.7).toInt()),
                ),
              ),
              const SizedBox(height: 60),
              Form(
                child: Column(
                  children: [
                    const CustomTextInput(
                      label: "YOUR NAME",
                      hintText: "youremail@example.com",
                    ),
                    const SizedBox(height: 20),
                    const CustomTextInput(
                      label: "YOUR EMAIL",
                      hintText: "youremail@example.com",
                    ),
                    const SizedBox(height: 20),
                    const CustomTextInput(
                      label: "YOUR PASSWORD",
                      hintText: "1234",
                      pass: true,
                    ),
                    const SizedBox(height: 20),
                    CustomTextInput(
                      label: "CONFIRM YOUR PASSWORD",
                      hintText: "1234",
                      pass: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ButtonGradient(
                buttonText: "SignUp",
                height: 55,
                fontSize: 20,
                onPressed: () {},
              ),
              const SizedBox(height: 30),
              CustomLink(
                primaryText: "Já tem uma conta? ",
                secondaryText: "Login",
                destination: () => const LoginPage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
