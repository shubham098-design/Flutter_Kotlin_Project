import 'package:eccomerce_with_mongodb/features/auth/provider/user_provider.dart';
import 'package:eccomerce_with_mongodb/features/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constrants/utils.dart';
import '../services/user_service.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    void login(){
      userProvider.login(
        emailController.text.trim(),
        passwordController.text.trim(),
        context
      );
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/amazon_in.png", // Amazon logo
                    height: 50,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email or mobile number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      if ( emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {
                        login();

                      }else{
                        showSnackBar(context, "Please fill all the fields");
                      }

                    },
                    child: userProvider.isLoading ? const CircularProgressIndicator() : const Text('Sign in'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    child: const Text('Create your Amazon account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
