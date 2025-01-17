import 'package:flutter/material.dart';
import 'package:worldreader/core/common/show_bottom_snack_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final firstNameController = TextEditingController(text: "");
  final lastNameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  final confirmPasswordController = TextEditingController(text: "");
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
                        height: 150,
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "First Name",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          focusColor: Colors.blue,
                          hoverColor: Colors.blue,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: const Color(0x0ff3645f).withOpacity(0.5),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your first name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Last Name",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          focusColor: Colors.blue,
                          hoverColor: Colors.blue,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: const Color(0x0ff3645f).withOpacity(0.5),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter your last name";
                          }
                          return null;
                        },
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
                            focusColor: Colors.blue,
                            hoverColor: Colors.blue,
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
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter an email";
                          }
                          return null;
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
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter a password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Confirm Password",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
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
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please repeat the password";
                          } else if (value.toString() !=
                              passwordController.text.toString()) {
                            return "passwords does not match";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (myKey.currentState!.validate()) {
                              showBottomSnackBar(
                                  context: context,
                                  message: "Account Created Successfully",
                                  durationSeconds: 2);
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
                          child: const Text("Submit")),
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
                            "Already have an account? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pop(context);
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: const Text(
                              "Log in",
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
