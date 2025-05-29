// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  TextEditingController userName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //register method
  void registerUser() async {
    // make sure password and confirm password match
    if (passwordController.text != confirmPasswordController.text) {
      //show error message
      showDialog(
        context: context,
        builder:
            (context) => const AlertDialog(
              title: Text(
                "Passwords don't match",
                style: TextStyle(fontSize: 18),
              ),
            ),
      );
    }
    //try creating the user
    // else {
    //   try {
    //     //create the user
    //     UserCredential? userCredential = await FirebaseAuth.instance
    //         .createUserWithEmailAndPassword(
    //         email: emailController.text, password: passwordController.text);
    //
    //     //pop the loading circle
    //     Navigator.pop(context);
    //   } on FirebaseAuthException catch (e) {
    //     //pop loading circle
    //     Navigator.pop(context);
    //
    //     //display the error message
    //     showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: Text(
    //             e.toString(),
    //             style: TextStyle(fontSize: 18),
    //           ),
    //         ));
    //   }
    // }
  }

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
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //logo
                    const Icon(Icons.notes, size: 80),

                    SizedBox(width: 10, height: 5),

                    //app name
                    const Text(
                      "K I S S A N  M I T R",
                      style: TextStyle(fontSize: 25),
                    ),

                    SizedBox(width: 10, height: 25),

                    //userName texfield
                    TextField(
                      decoration: InputDecoration(
                        hintText: "User Name",
                        border: OutlineInputBorder(
                          gapPadding: 20,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: userName,
                    ),

                    SizedBox(width: 10, height: 15),

                    //email texfield
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Email ID",
                        border: OutlineInputBorder(
                          gapPadding: 20,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: emailController,
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
                      controller: passwordController,
                    ),

                    SizedBox(width: 10, height: 10),

                    //confirm password textfield
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                          gapPadding: 20,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: confirmPasswordController,
                    ),

                    SizedBox(width: 10, height: 10),

                    //register in button
                    GestureDetector(
                      onTap: registerUser,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: const Center(
                          child: Text(
                            "Register",
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
                        const Text("Already have a Account?"),

                        SizedBox(width: 5, height: 5),

                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login Here",
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
