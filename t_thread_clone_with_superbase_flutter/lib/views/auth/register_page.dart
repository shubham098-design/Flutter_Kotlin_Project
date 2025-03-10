import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/controller/auth_controller.dart';

import '../../routes/routes_name.dart';
import '../../widget/auth_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());

  void submit(){
    if(formKey.currentState!.validate()){
      controller.register(nameController.text, emailController.text, passwordController.text);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                        Text("Register",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        Text("Sign up to continue",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        AuthInput(controller: nameController,label: "Username",hintText: "Enter your Username",validator: ValidationBuilder().minLength(3).maxLength(50).build(),),
                        SizedBox(height: 20,),
                        AuthInput(controller: emailController,label: "Email",hintText: "Enter your email",validator: ValidationBuilder().email().build(),),
                        SizedBox(height: 20,),
                        AuthInput(controller: passwordController,label: "Password",hintText: "Enter your password",isPasswordField: true,validator: ValidationBuilder().minLength(6).maxLength(50).build(),),
                        SizedBox(height: 20,),
                        AuthInput(controller: confirmPasswordController,label: "Confirm Password",hintText: "Enter your password",isPasswordField: true,validator:(value){
                          if(value != passwordController.text){
                            return "Password does not match";
                          }
                          return null;
                        },),
                        SizedBox(height: 20,),
                        Obx(
                          ()=> ElevatedButton(onPressed: (){
                            submit();
                          },style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size.fromHeight(40)),
                          ), child: Text(controller.registerLoading.value ? "Loading..." : "Sign Up")),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            TextButton(onPressed: (){
                              Get.toNamed(RouteName.login);
                            }, child: Text(" Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
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
