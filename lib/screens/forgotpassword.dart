import 'package:agromate/ui/components/custombutton.dart';
import 'package:agromate/ui/components/customfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      if(!mounted) return;
      setState(() => isLoading = true);

      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
if(!mounted) return;
        setState(() => isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Password reset email sent! Check your inbox."),
            backgroundColor: Colors.green,
          ),
        );
      } on FirebaseAuthException catch (e) {
        if(!mounted) return;
        setState(() => isLoading = false);

        String errorMessage;
        switch (e.code) {
          case 'invalid-email':
            errorMessage = "Invalid email address.";
            break;
          case 'user-not-found':
            errorMessage = "No user found with this email.";
            break;
          default:
            errorMessage = "Something went wrong. Please try again.";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Don't worry, we have got your back!",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 200),
                const Text(
                  "Please enter your email address",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  hintText: 'Email Address',
                  prefixIcon: Icons.email,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegEx = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegEx.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: 'Reset Password',
                        onPressed: _resetPassword,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
