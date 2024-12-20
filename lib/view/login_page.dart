import 'package:flutter/material.dart';
import 'package:worldreader/core/common/show_bottom_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  final myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/worldmap_login_bg.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: myKey,
                child: SingleChildScrollView(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/WorldReaderLogo.png',
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                                color:
                                    const Color(0xFF36454F).withOpacity(0.5)),
                            hintText: 'example@email.com',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "enter an email";
                          } else if (value == "admin@email.com") {
                            return null;
                          }
                          return "email not registered";
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                color:
                                    const Color(0xFF36454F).withOpacity(0.5)),
                            hintText: '*******',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "enter a password";
                          } else if (value == "admin") {
                            return null; // correct creds
                          }
                          return "incorrect password";
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (myKey.currentState!.validate()) {
                              showBottomSnackBar(
                                  context: context, message: "Login Success");
                              Navigator.pushReplacementNamed(
                                  context, '/dashboard');
                            } else {
                              showBottomSnackBar(
                                  context: context,
                                  message: "Login error",
                                  color: Colors.red);
                            }
                          },
                          child: const Text("Log in")),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Log in with  ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Image.asset(
                            "assets/icons/login_with_google_icon.png",
                            height: 19,
                          ),
                          const Padding(padding: EdgeInsets.all(3)),
                          Image.asset(
                            "assets/icons/login_with_facebook_icon.png",
                            height: 19,
                          ),
                          const Padding(padding: EdgeInsets.all(3)),
                          Image.asset(
                            "assets/icons/login_with_github_icon.png",
                            height: 19,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Create new account? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signup');
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
