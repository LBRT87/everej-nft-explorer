import 'package:flutter/material.dart';
import '../service/api_everej.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  bool isAggree = false;

  String? usernameError;
  String? emailError;
  String? passwordError;
  String? confirmError;

  void resetError() {
    setState(() {
      usernameError = null;
      emailError = null;
      passwordError = null;
      confirmError = null;
    });
  }

  void showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void register() async {
    resetError();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirm = confirmController.text;

    if (email.isEmpty) {
      setState(() {
        emailError = "Assign Your Email";
      });
    }

    if (!email.contains("@")) {
      setState(() {
        emailError = "Please Use Format Email @";
        return;
      });
    }

    if (email.length < 8) {
      setState(() => 
        emailError = "E-mail name to short" ,
      );
    }

    if (password.length < 6) {
      setState(
        () => passwordError = "Password Must Be More Equal Than 6 Characters",
      );
      return;
    }

    if (password != confirm) {
      setState(() => confirmError = "Password Different");
      return;
    }

    if (!isAggree) {
      showSnack("R u Agree the terms ?");
      return;
    }

    bool regisSuksess = await ApiEverej.registration(email, password);
    if (!mounted) {
      return;
    }

    if (!regisSuksess) {
      showSnack("Your E-mail Already Exists..");
      return;
    }

    showSnack("Registration Success ");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/logo_ej.png", height: 300),

            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Regist You're E-mail",
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
                labelText: "Regist You're Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorText: passwordError,
              ),
            ),

            const SizedBox(height: 30),
            TextField(
              controller: confirmController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm You're Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorText: confirmError,
              ),
            ),

            CheckboxListTile(
              value: isAggree,
              title: const Text("I agree EvereJ Terms & Conditions"),
              onChanged: (val) => setState(() => isAggree = val!),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: register,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text("REGISTER"),
            ),
          ],
        ),
      ),
    );
  }
}
