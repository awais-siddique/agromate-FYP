import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agromate/screens/login.dart';
import 'package:agromate/firebase/firebasehelper.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Service service = Service();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleCreateAccount() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if(!mounted) return;
      setState(() => isLoading = true);

      service.createUser(
        context,
        emailController.text,
        passwordController.text,
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => isLoading = false);
      });

      emailController.clear();
      passwordController.clear();
    } else {
      service.errorBox(context, "Please Fill All Fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
          },
        ),
      ),
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: isLoading,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Email Address',
                        prefixIcon: const Icon(Icons.email, color: Colors.green),
                          enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.green, width: 1.5),
    ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.green, width: 1.5),
                        ),
                          border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.green, width: 1.5),
    ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        prefixIcon: const Icon(Icons.lock, color: Colors.green),
                        enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.green, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.green, width: 1.5),
    ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.green, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputField(hintText: "Phone Number", icon: Icons.phone,keyboardType: TextInputType.phone,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
     LengthLimitingTextInputFormatter(15),
  ],),
                    const SizedBox(height: 20),
                    const InputField(hintText: "Full Name", icon: Icons.person),
                    const SizedBox(height: 20),
                    const InputField(hintText: "City", icon: Icons.location_city),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        onPressed: isLoading ? null : handleCreateAccount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Create Account',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                        child: const Text.rich(
                          TextSpan(
                            text: "Already a member? ",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            const ModalBarrier(
              dismissible: false,
              color: Colors.black38,
            ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
    final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const InputField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
        this.controller,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1.5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
           keyboardType: keyboardType,
            inputFormatters: inputFormatters,
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.green),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
