import 'package:flutter/material.dart';
import 'package:kissan_mitr/login/no_account.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFFCA),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 400,
              height: 600,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB9D4AA), Color(0xFF5A827E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54, // Shadow color
                    blurRadius: 10, // Softness of the shadow
                    offset: Offset(0, 4), // Position of the shadow (x, y)
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //logo
                    Icon(Icons.notes, size: 80),

                    SizedBox(width: 10, height: 5),

                    //app name
                    Text(
                      "K I S S A N  M I T R",
                      style: TextStyle(fontSize: 25),
                    ),

                    SizedBox(width: 10, height: 25),

                    //email texfield
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Username",
                        border: OutlineInputBorder(
                          gapPadding: 20,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      // controller: emailController,
                    ),

                    SizedBox(width: 10, height: 10),

                    //password textfield
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          gapPadding: 20,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      // controller: passwordController,
                    ),

                    SizedBox(width: 10, height: 10),

                    //forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: Text(
                                      "Please remember your password",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                            );
                          },
                          child: Text("Forgot Password ?"),
                        ),
                      ],
                    ),

                    SizedBox(width: 10, height: 10),

                    //sign in button
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10, height: 10),

                    //don't have a account? Register Now
                    Row(
                      children: [
                        const Text("Dont have an Account?"),

                        const SizedBox(width: 5, height: 5),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Register Here",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
