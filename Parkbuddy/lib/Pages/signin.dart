import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:plz/Pages/homepage.dart';
import 'package:plz/Pages/profile_menu.dart';
import 'package:plz/Pages/signup.dart';
import 'package:plz/components/google_login.dart';
import 'package:plz/components/login_page_textfields.dart';

class Signin extends StatelessWidget {
  Signin({super.key});
  final useremailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void usernameerror() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(
                Icons.error,
                color: Colors.red,
                size: 40,
              ),
              title: Text(
                "Email not found !! Try again",
                style: TextStyle(color: Colors.grey[800]),
              ),
            );
          });
    }

    void passworderror() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: Icon(
                Icons.error,
                color: Colors.red,
                size: 40,
              ),
              title: Text(
                "Wrong password!! Try again",
                style: TextStyle(color: Colors.grey[800]),
              ),
            );
          });
    }

    void signinmethod() async {
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            width: 120,
            color: Colors.grey.shade300,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Checking info",
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      );

      print("CHecking");

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: useremailcontroller.text, password: passwordcontroller.text);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        print("Error connecting: "+e.code);
        Navigator.pop(context);
        if (e.code == 'user-not-found' || e.code == 'invalid-email') {
          //popup for username not found
          usernameerror();
        } else if (e.code == 'wrong-password' ||
            e.code == 'invalid-credential') {
          //wrond answer popup
          passworderror();
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              //logo
              const Icon(
                Icons.car_crash,
                size: 100,
                //color: Colors.black,
              ),
              const SizedBox(
                height: 30,
              ),

              const Text(
                "Welcome back",
                style: TextStyle(
                    //color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),

              //username text field
              LoginTextField(
                thiscontroller: useremailcontroller,
                obscuretext: false,
                hinttext: "Email",
              ),
              const SizedBox(
                height: 20,
              ),

              //Password textfield
              LoginTextField(
                thiscontroller: passwordcontroller,
                obscuretext: true,
                hinttext: "Password",
              ),
              const SizedBox(height: 10),

              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              //sign-in button
              GestureDetector(
                onTap: signinmethod,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      //color: Colors.blueAccent,
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: const Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    " Or continue with ",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),

              //or contnue with google
              const GoogleLogin(),

              const SizedBox(
                height: 30,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return Signup();
                  }));
                }, //go to signup
                child: RichText(
                  text: TextSpan(
                    text: "Not a member?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: " Register now",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 40,
              ),

              ProfileMenuWidget(
                title: "Home",
                icon: LineAwesomeIcons.home_solid,
                onPress: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
