import 'package:flutter/material.dart';
import 'package:worldreader/view/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: const Color(0xFF36454F).withOpacity(0.5)),
                        hintText: 'example@email.com',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    keyboardType: TextInputType.emailAddress,
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
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                            color: const Color(0xFF36454F).withOpacity(0.5)),
                        hintText: '*******',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF009CDA), // Blue background
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0))),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
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
          )
        ],
      ),
    );
  }
}
