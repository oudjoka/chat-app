import 'package:discussion/constants.dart';
import 'package:discussion/helpers/show_snack_bar.dart';
import 'package:discussion/screens/chat_page.dart';
import 'package:discussion/screens/register_page.dart';
import 'package:discussion/widgets/custom_button.dart';
import 'package:discussion/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Form(
            key: formkey,
            child: ListView(
              children: [
               const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  kLogo,
                  width: 200,
                  height: 200,
                ),
              const  SizedBox(
                  height: 20,
                ),
              const  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ChaTTy",
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              const  SizedBox(
                  height: 30,
                ),
              const  Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
               const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
              const  SizedBox(
                  height: 8,
                ),
                CustomFormTextField(
                  obscureText: true,
                  hintText: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                ),
              const  SizedBox(
                  height: 37,
                ),
                CustomButton(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isloading = true;
                        setState(() {});
                        try {
                          await loginUserCredentialMethod();
                          showSnackBar(
                              context: context,
                              message: "Success.",
                              isSuccess: true);
                          Navigator.pushReplacementNamed(context, ChatPage.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                                context: context,
                                message: 'No user found for that email.');
                            //print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                                context: context,
                                message:
                                    'Wrong password provided for that user.');
                            //print('Wrong password provided for that user.');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                        isloading = false;
                        setState(() {});
                      }
                    },
                    buttonText: 'Sign IN'),
              const  SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const  Text("Don't have an account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child:const Text(
                        "   SIGN UP",
                        style: TextStyle(
                          color: Color(0xFF71E1A9),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUserCredentialMethod() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
