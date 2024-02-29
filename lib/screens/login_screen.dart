import 'package:chat_app/cubit/login_cubit.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../comman/button.dart';
import '../comman/textfield.dart';
import '../constans/constans.dart';
import 'chat_screen.dart';

class LoginScreen extends StatelessWidget {
  String? password;
  String? email;
  static String id = 'Login Screen';
  GlobalKey<FormState> formkey = GlobalKey();
  bool modalpro = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginLoading){
          modalpro=true;
        }else if(state is LoginSuccess){
          Navigator.pushNamed(context, ChatScreen.id);
        }else if(state is LoginFailure){
          showSnackbar(context, state.errMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: modalpro,
        child: Scaffold(
          backgroundColor: kMaincolor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage(kLogo)),
                      const Text(
                        'Scholar chat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 42,
                          color: Colors.white70,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            ' Login ',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        onchange: (x) {
                          email = x;
                        },
                        hinttext: 'Email',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        onchange: (x) {
                          password = x;
                        },
                        hinttext: 'password',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: 'Login',
                        ontap: () async {
                          if (formkey.currentState!.validate())
                          {
                           BlocProvider.of<LoginCubit>(context).userLogin(email: email!, password: password!);
                          } else {}
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('did not have an account ',
                              style: TextStyle(
                                  color: Color(0xffc7ede6), fontSize: 16)),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, SingInScreen.id);
                              },
                              child: const Text('Register',
                                  style: TextStyle(
                                      color: Color(0xffc7ede6), fontSize: 18))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }

}
