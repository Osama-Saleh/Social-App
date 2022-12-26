// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var fromKey = GlobalKey<FormState>();
  bool isSecret = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: fromKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "REGISTER...",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      myTextFormField(
                        controller: nameController,
                        onFieldSubmitted: ((value) {
                          if (fromKey.currentState!.validate()) {}
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Email";
                          }
                          return null;
                        },
                        label: "Name",
                        prefixIcon: Icon(Icons.person),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      myTextFormField(
                        controller: emailController,
                        onFieldSubmitted: ((value) {
                          if (fromKey.currentState!.validate()) {}
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Email";
                          }
                          return null;
                        },
                        label: "Email",
                        prefixIcon: Icon(Icons.mail_outline),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      myTextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Password";
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            if (fromKey.currentState!.validate()) {}
                          },
                          obscureText: isSecret,
                          label: "Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isSecret = !isSecret;
                                });
                                print("isSecret ${isSecret}");
                              },
                              icon: isSecret
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
                          prefixIcon: Icon(Icons.lock)),
                      SizedBox(
                        height: 20,
                      ),
                      myTextFormField(
                        controller: phoneController,
                        onFieldSubmitted: ((value) {
                          if (fromKey.currentState!.validate()) {}
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your phone number";
                          }
                          return null;
                        },
                        label: "Phone",
                        prefixIcon: Icon(Icons.phone),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingDataState,
                        builder: (context) => Container(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              onPressed: () {
                                if (fromKey.currentState!.validate()) {
                                  HomeCubit.get(context).getRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                                }

                                print("Sing Up");
                              },
                              child: Text(
                                "Sing Up",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              )),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
