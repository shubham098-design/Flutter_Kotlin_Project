import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../routes/routes_name.dart';
import '../../widget/auth_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  void submit(){
    if(formKey.currentState!.validate()){
      authController.login(emailController.text, passwordController.text);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset("assets/images/logo.png",width: 60,height: 60,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Text("Welcome back",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        AuthInput(controller: emailController,label: "Email",hintText: "Enter your email",validator: ValidationBuilder().email().build(),),
                        SizedBox(height: 20,),
                        AuthInput(controller: passwordController,label: "Password",hintText: "Enter your password",isPasswordField: true,validator: ValidationBuilder().minLength(6).maxLength(50).build(),),
                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          submit();
                        }, child: Text("Login"),style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size.fromHeight(40)),
                        )),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(onPressed: (){
                              Get.toNamed(RouteName.register);
                            }, child: Text(" Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
