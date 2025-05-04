import 'package:agromate/firebase/firebasehelper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final eController = TextEditingController();
  final pController = TextEditingController();
  Service service = Service();

  bool loading = false;

  @override
  void dispose() {
    eController.dispose();
    pController.dispose();
    super.dispose();
  }

  void handleLogin() {
    if (eController.text.isNotEmpty && pController.text.isNotEmpty) {
      if(!mounted) return;
      setState(() => loading = true);

      // Call login function
      service.loginUser(context, eController.text, pController.text);

      // Optional: turn off loading after 2 seconds (or after navigation)
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => loading = false);
      });
    } else {
      service.errorBox(context, "Please Fill All Fields");
    }

    pController.clear();
    eController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: loading,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.greenAccent, Colors.green],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/logo.png'),
                          height: 100,
                        ),
                        const SizedBox(height: 30),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Center(
                                  child: Text(
                                    'Sign in to your Account',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: eController,
                                  decoration: InputDecoration(
                                    hintText: 'Email Address',
                                    prefixIcon: const Icon(Icons.email,
                                        color: Colors.green),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: pController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Colors.green),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 2),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/forgot-password');
                                    },
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: loading ? null : handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: loading
                                        ? const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.login,
                                                  color: Colors.white),
                                              SizedBox(width: 10),
                                              Text('Login',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have an account?",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(
                                            context, '/register');
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.green,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (loading)
            const ModalBarrier(
              dismissible: false,
              color: Colors.black38,
            ),
        ],
      ),
    );
  }
}
