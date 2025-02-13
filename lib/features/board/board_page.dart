import 'package:flutter/material.dart';
import 'package:test/common/constants/app_colors.dart';
import 'package:test/components/button_gradient.dart';
import 'package:test/features/login/login_page.dart';
import 'package:test/features/sign_up/sign_up_page.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(50),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: _buildMainContent(),
              ),
            ),
            _textOfLogin(context),
          ],
        ),
      ),
    );
  }

		void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _textOfLogin(BuildContext context) {
    return TextButton(
      onPressed: () => _navigateToLogin(context),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Já tem uma conta? ",
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: "Login",
              style: TextStyle(color: AppColors.indigo600),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        const SizedBox(height: 40),
        _buildSubtitle(),
        const SizedBox(height: 50),
        _buildButton(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      "Organizze",
      style: TextStyle(
        color: AppColors.indigo600,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubtitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "O melhor app para organizar sua ",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: "VIDA",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.indigo600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return ButtonGradient(
      buttonText: "Start now!",
      height: 50,
      fontSize: 20,
      onPressed: () {},
    );
  }
}
