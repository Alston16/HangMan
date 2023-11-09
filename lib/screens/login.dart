import 'package:flutter/material.dart';
import '../services/authorization.dart';
import 'loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(title: const Text('User Login')),
            body: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 400, // Set the maximum width as needed
                      ),
                      child: TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? "Enter an email" : null,
                        decoration: const InputDecoration(labelText: 'Email'),
                        onChanged: (val) => {setState(() => email = val)},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 400, // Set the maximum width as needed
                      ),
                      child: TextFormField(
                        validator: (val) => val!.length < 6
                            ? "The password should have more than 6 characters"
                            : null,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText:
                            true, // Set obscureText to true to hide password
                        onChanged: (val) => {setState(() => password = val)},
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Invalid email or password';
                              loading = false;
                            });
                          } else {
                            setState(() {
                              error = '';
                              loading = false;
                            });
                            Navigator.pushNamed(context, '/menu');
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/registration');
                      },
                      child:
                          const Text('Don\'t have an account? Register here'),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
