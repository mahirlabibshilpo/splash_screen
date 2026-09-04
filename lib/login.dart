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
  // Email ar Password controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Password hide/show state
  bool isPasswordHidden = true;

  // Login function
  void loginUser() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // 1. Check if empty
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both Email and Password!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 2. Check credentials using AuthService
    bool isSuccess = AuthService().login(email, password);

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to Home Page
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
              // Logo
              Image.asset(
                'assets/green_environment_logo.png',
                height: 90,
              ),

              const SizedBox(height: 30),

              // Login Title
              const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 30),

              // Email Field
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: Colors.green),
                ),
              ),

              const SizedBox(height: 15),

              // Password Field
              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: 'Password',
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

              // Forgot Password
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

              // Login Button
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

              // Sign Up Option
              GestureDetector(
                onTap: () {
                  // Navigate to Sign Up Page
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
