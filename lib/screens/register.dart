import 'package:flutter/material.dart';
import '../services/authorization.dart';
import 'loading.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(title: const Text('User Registration')),
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
                              val!.isEmpty ? "Enter an username" : null,
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                          onChanged: (val) => {setState(() => username = val)},
                        )),
                    const SizedBox(height: 20),
                    Container(
                        constraints: const BoxConstraints(
                          maxWidth: 400, // Set the maximum width as needed
                        ),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? "Enter an email" : null,
                          decoration: const InputDecoration(labelText: 'Email'),
                          onChanged: (val) => {setState(() => email = val)},
                        )),
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
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  username, email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Invalid email';
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
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text('Already have an account? Login here'),
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
