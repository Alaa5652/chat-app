import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../comman/button.dart';
import '../comman/textfield.dart';
import '../constans/constans.dart';
import '../cubit/register_cubit.dart';

class SingInScreen extends StatelessWidget {
  String? password;
  static String id = 'SingInPage';
  String? email;
  GlobalKey<FormState> formkey = GlobalKey();
  bool modalpro = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state is RegisterLoading){
          modalpro=true;
        }else if(state is RegisterSuccess){
          Navigator.pushNamed(context, ChatScreen.id);
        }else if(state is RegisterFailure){
          showSnackbar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                              ' Register',
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
                          text: 'Register',
                          ontap: () async {
                            if (formkey.currentState!.validate()) {
                              BlocProvider.of<RegisterCubit>(context)
                                  .userRegisteration(
                                  email: email!, password: password!);
                            } else {}
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('already have an account ',
                                style: TextStyle(
                                    color: Color(0xffc7ede6), fontSize: 16)),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Login',
                                    style: TextStyle(
                                        color: Color(0xffc7ede6),
                                        fontSize: 18))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showSnackbar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }


}
