import 'package:flutter/material.dart';
import 'package:my_app/pages/main_page.dart';
import 'package:my_app/pages/registration_page.dart';

import '../service/api_everej.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isAggre = false;

  String? emailError;
  String? passwordError;

  void resetError() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  void login() async {
    resetError();
    String email = emailController.text.trim();
    String password = passwordController.text;

    if (email.isEmpty) {
      setState(() => emailError = "Your E-mail is NULL");
      showSnack("Please Assign E-mail..");
      return;
    }

    if (!email.contains('@')) {
      setState(() => emailError = "Please Use Format Email @");
      showSnack("E-mail Format @");
      return;
    }

    if (email.length < 8) {
      setState(
        () => emailError = "At least E-mail length more than 8 characters",
      );
      showSnack("E-mail Minimum 8 Characters");
      return;
    }

    if (password.isEmpty) {
      setState(
        () => passwordError = "Password Must Be Required",
      );
      showSnack("Please Assign Your Password");
      return;
    }

    if (password.length < 6) {
      setState(
        () => passwordError = "Password Must Be More Equal Than 6 Characters",
      );
      showSnack("Your Password To Short");
      return;
    }

    if (!isAggre) {
      showSnack("R u Agree the te\rms ?");
      return;
    }

    bool loginSukses = await ApiEverej.login(email, password);
    if (!mounted) {
      return;
    }

    if (!loginSukses) {
      showSnack("Failed Login to EvereJ..");
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success Login to EvereJ"),
        content: const Text("Welcome To The Best NFT Store"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => MainPage(email: email)),
                (route) => false,
              );
            },
            child: const Text("Okee.."),
          ),
        ],
      ),
    );
  }

  void showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/logo_ej.png", height: 300),

              const SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "You're E-mail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorText: emailError,
                ),
              ),

              const SizedBox(height: 30),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "You're Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorText: passwordError,
                ),
              ),

              CheckboxListTile(
                value: isAggre,
                contentPadding: EdgeInsets.zero,
                title: const Text("I agree EvereJ Terms & Conditions"),
                onChanged: (val) {
                  setState(() => isAggre = val!);
                },
              ),

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("LOGIN"),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegistrationPage()),
                  );
                },
                child: const Text("Dont't have account? Registration"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
