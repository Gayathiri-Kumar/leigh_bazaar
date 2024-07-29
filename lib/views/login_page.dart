import 'package:flutter/material.dart';
import 'package:leigh_bazaar/controllers/auth_controller.dart';
import 'package:leigh_bazaar/utils/colors.dart';
import 'package:leigh_bazaar/utils/snackbar.dart';
import 'package:provider/provider.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: lightblue,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(height: height / 20),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'e-Shop',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: width / 18,
                      fontWeight: FontWeight.bold,
                      color: blue,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height / 4.5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: white,
                    hintText: "Email",
                    hintStyle: TextStyle(
                        fontSize: 14, fontFamily: 'Poppins', color: darkblue),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: white),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  bool EmailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!EmailValid) {
                    return 'Please Enter a valid Email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: height / 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      hintText: "Password",
                      suffixIcon: IconButton(
                        iconSize: 20,
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: blue,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: darkblue,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: lightblue),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      // Password validation criteria
                      final passwordPattern = RegExp(
                          r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$');
                      if (!passwordPattern.hasMatch(value)) {
                        return "Please Enter a Strong Password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: height / 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: blue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await Provider.of<AuthController>(context,
                                listen: false)
                            .login(
                          _emailController.text,
                          _passwordController.text,
                        );

                        // CustomSnackbar.showSnackbar(context, "Login Sucessful");
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } catch (e) {
                        CustomSnackbar.showSnackbar(
                            context, "Invalid Credentials");
                      }
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New here?',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: MediaQuery.sizeOf(context).width / 28,
                      color: darkblue),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.sizeOf(context).width / 22,
                      color: blue,
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
