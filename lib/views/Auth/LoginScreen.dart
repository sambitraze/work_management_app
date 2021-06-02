import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_management_app/views/Auth/SignUpScreen.dart';
import 'package:work_management_app/views/LandingScreen.dart';
import 'package:work_management_app/views/Services/authService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = new GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    String msg = await AuthService.authenticate(
        emailController.text, passwordController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
    if (msg == "Sign in successfull") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login Successfull"),
        ),
      );
      prefs.setBool("login", true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LandingScreen(),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset("assets/images/login.png"),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: formWidget(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formWidget(BuildContext context) {
    return Container(
      child: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Log-in",
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 32,
            ),
            formheaderWidget(context, 'Email/Username'),
            inputWidget(emailController, "Please Enter your Email", false),
            SizedBox(
              height: 18,
            ),
            formheaderWidget(context, 'Password'),
            inputWidget(passwordController, "Please Enter your Password", true),
            SizedBox(
              height: 40,
            ),
            buttonWidget(
              context,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an account ? Sign up",
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonWidget(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : MaterialButton(
            minWidth: 360,
            height: 55,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            color: Color(0xff314B8C),
            onPressed: () async {
              await login();
            },
            child: Text(
              "Login",
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          );
  }

  Widget formheaderWidget(BuildContext context, String text) {
    return Text(
      text,
      style: GoogleFonts.nunito(
          color: Color(0xff314B8C), fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget inputWidget(
      TextEditingController textEditingController, String validation, bool) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextFormField(
        controller: textEditingController,
        obscureText: bool,
        validator: (value) => value!.isEmpty ? validation : null,
      ),
    );
  }
}
