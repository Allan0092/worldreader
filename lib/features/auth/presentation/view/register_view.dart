import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:worldreader/features/auth/presentation/view_model/register/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _firstNameController = TextEditingController(text: "");

  final _lastNameController = TextEditingController(text: "");

  final _emailController = TextEditingController(text: "");

  final _passwordController = TextEditingController(text: "");

  final _confirmPasswordController = TextEditingController(text: "");

  final _myKey = GlobalKey<FormState>();

  // check for camera permission
  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          // send Image to server
          context.read<RegisterBloc>().add(
                UploadImage(file: _img!),
              );
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
                key: _myKey,
                child: SingleChildScrollView(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   'assets/icons/WorldReaderLogo.png',
                      //   height: 150,
                      // ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey,
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _browseImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text("Gallery"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _img != null
                                ? FileImage(_img!)
                                : const AssetImage(
                                        'assets/icons/user_profile_icon.png')
                                    as ImageProvider,
                          ),
                        ),
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
                        controller: _firstNameController,
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
                        style: const TextStyle(color: Colors.black),
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
                        controller: _lastNameController,
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
                        style: const TextStyle(color: Colors.black),
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
                        controller: _emailController,
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
                        controller: _passwordController,
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
                        controller: _confirmPasswordController,
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
                              _passwordController.text.toString()) {
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
                            if (_myKey.currentState!.validate()) {
                              // showBottomSnackBar(
                              //     context: context,
                              //     message: "Account Created Successfully",
                              //     durationSeconds: 2);
                              // Navigator.pushReplacementNamed(context, '/login');
                              final registerState =
                                  context.read<RegisterBloc>().state;
                              final imageName = registerState.imageName;
                              context.read<RegisterBloc>().add(
                                    RegisterUser(
                                      context: context,
                                      fName: _firstNameController.text,
                                      lName: _lastNameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      image: imageName,
                                    ),
                                  );
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
                              Navigator.pop(context);
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
