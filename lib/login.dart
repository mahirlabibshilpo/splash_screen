import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'home.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;

  void loginUser() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both Email and Password!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool isSuccess = AuthService().login(email, password);

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password.'),
          backgroundColor: Colors.red,
        ),
      );
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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/green_environment_logo.png',
                height: 90,
              ),

              const SizedBox(height: 20),

              const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'aust@gmail.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: Colors.green),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: '123456',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock, color: Colors.green),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password reset feature coming soon!'),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: loginUser,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
