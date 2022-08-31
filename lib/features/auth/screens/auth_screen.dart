import 'package:amazon_app/widgets/custom_button.dart';
import 'package:amazon_app/widgets/custom_textfield.dart';
import 'package:amazon_app/constants/constant.dart';
import 'package:amazon_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final GlobalKey<FormState> _signInGlobalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpGlobalKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void signUpUser() {
    _authService.signUpUser(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    _authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.greyBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            ListTile(
              tileColor: _auth == Auth.signUp
                  ? GlobalVariable.backgroundColor
                  : GlobalVariable.greyBackgroundColor,
              leading: Radio(
                value: Auth.signUp,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
                activeColor: GlobalVariable.secondaryColor,
              ),
              title: const Text(
                'Create Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (_auth == Auth.signUp)
              Form(
                key: _signUpGlobalKey,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: GlobalVariable.backgroundColor),
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Name',
                        controller: _nameController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Email',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Password',
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        btnText: 'Sign Up',
                        onPress: () async {
                          if (_signUpGlobalKey.currentState!.validate()) {
                            signUpUser();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.signIn
                  ? GlobalVariable.backgroundColor
                  : GlobalVariable.greyBackgroundColor,
              leading: Radio(
                value: Auth.signIn,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
                activeColor: GlobalVariable.secondaryColor,
              ),
              title: const Text(
                'Sign-In',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (_auth == Auth.signIn)
              Form(
                key: _signInGlobalKey,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: GlobalVariable.backgroundColor),
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Email',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Password',
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        btnText: 'Sign In',
                        onPress: () {
                          if (_signInGlobalKey.currentState!.validate()) {
                            signInUser();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}

enum Auth { signIn, signUp }
