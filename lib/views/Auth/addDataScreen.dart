import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work_management_app/Services/userService.dart';
import 'package:work_management_app/models/User.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController email2Controller = TextEditingController();
  TextEditingController githubController = TextEditingController(text: "NA");
  TextEditingController linkedinController = TextEditingController(text: "NA");
  TextEditingController facebookController = TextEditingController(text: "NA");
  TextEditingController twitterController = TextEditingController(text: "NA");
  TextEditingController instagramController = TextEditingController(text: "NA");
  TextEditingController photoUrlController = TextEditingController();

  bool loading = false;

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
                flex: 3,
                child: Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset("assets/images/signup.png"),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
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

  final formkey = new GlobalKey<FormState>();
  Widget formWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                "Add Data",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 32,
              ),
              formheaderWidget(context, 'Phone'),
              inputWidget(phoneController, "Enter your Phone No", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Roll Number'),
              inputWidget(rollController, "Enter your Roll Number", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Date of Birth'),
              inputWidget(dobController, "Enter your DOB", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Designation'),
              inputWidget(
                  designationController, "Enter your Designation", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Department'),
              inputWidget(departmentController, "Enter your Department", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'KiiT Email Id'),
              inputWidget(email2Controller, "Enter your KiiT Email", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Github Profile URL'),
              inputWidget(githubController, "Enter your Github Url", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Likedin Profile URL'),
              inputWidget(linkedinController, "Enter your LinkedIn Url", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Facebook Profile URL'),
              inputWidget(instagramController, "Enter your Facebook Profile", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Instagram Profile URL'),
              inputWidget(instagramController, "Enter your Instagram", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Twitter Profile URL'),
              inputWidget(twitterController, "Enter your Twitter Url", false),
              SizedBox(
                height: 18,
              ),
              formheaderWidget(context, 'Photo URL'),
              inputWidget(photoUrlController, "Enter your Photo Url", false),
              SizedBox(
                height: 40,
              ),
              buttonWidget(
                context,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          )),
    );
  }

  check() {
    return true;
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
              // await login();

              if (formkey.currentState!.validate()) {
                User user = await UserService.getUser();
                setState(() {
                  user.department = departmentController.text;
                  user.desgination = designationController.text;
                  user.dob = dobController.text;
                  user.phone = phoneController.text;
                  user.roll = rollController.text;
                  user.photoUrl = photoUrlController.text;
                  user.github = githubController.text;
                  user.linkedin = linkedinController.text;
                  user.twitter = twitterController.text;
                  user.instagram = instagramController.text;
                  user.facebook = facebookController.text;
                  user.email2 = email2Controller.text;
                });
                print(user.toJson());
                bool updated =
                    await UserService.updateUser(jsonEncode(user.toJson()));
                print(updated);
              } else {
                SnackBar(
                  content: Text("Check all fields"),
                  duration: Duration(milliseconds: 800),
                );
              }
            },
            child: Text(
              "Sign Up",
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
