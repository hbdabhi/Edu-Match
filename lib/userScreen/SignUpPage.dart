import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/userScreen/verifyOtpScreen.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController Name = TextEditingController();
  TextEditingController phone = TextEditingController(text: "+91");
  TextEditingController password = TextEditingController();
  bool _ispass = true;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double ScreenHeight = size.height;
    double ScreenWidth = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: ScreenHeight * 0.1,),
            Center(
              child: Padding(
                padding: EdgeInsets.all(ScreenWidth * 0.05),
                child: Column(
                  children: [
                    Text('WELCOME TO MATRIMONY ', style: TextStyle(
                        fontSize: ScreenWidth * 0.07,
                        color: Colors.teal[800],
                        fontWeight: FontWeight.w800),),
                    Text('APPLICATION', style: TextStyle(
                        fontSize: ScreenWidth * 0.07,
                        color: Colors.teal[800],
                        fontWeight: FontWeight.w800),),

                  ],
                ),
              ),
            ),
            SizedBox(height: ScreenHeight * 0.021,),
            Center(
              child: Container(
                padding: EdgeInsets.all(ScreenWidth * 0.015),
                height: ScreenHeight * 0.53,
                width: ScreenWidth * 0.85,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54, blurRadius: ScreenWidth * 0.04)
                    ],
                    border: BoxBorder.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(ScreenWidth * 0.050),
                    gradient: LinearGradient(
                        colors: [Colors.teal, Colors.tealAccent],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft
                    )
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Spacer(flex: 2,),
                      Text('Create Account', style: TextStyle(
                          fontSize: ScreenWidth * 0.07,
                          color: Colors.black87,
                          fontWeight: FontWeight.w800),),
                      Spacer(flex: 4,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is Required";
                          }
                          return null;
                        },
                        controller: Name,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Enter Name',
                            prefixIcon: Icon(Icons.person)
                        ),
                      ),
                      Spacer(flex: 2,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Number is Required";
                          }
                          if (value.length != 13) {
                            return "phone number is 10 numbers";
                          }
                          return null;
                        },
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Enter Phone Number',
                            prefixIcon: Icon(Icons.phone)
                        ),
                      ),
                      Spacer(flex: 2,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is Required";
                          }
                          if (value.length < 6) {
                            return "Password must be a 6 character";
                          }
                          return null;
                        },
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _ispass,
                        decoration: InputDecoration(
                          hintText: 'Set Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(onPressed: () {
                            print(_ispass);
                            setState(() {
                              _ispass = !_ispass;
                            });
                          },
                              icon: Icon(_ispass ? Icons.visibility : Icons
                                  .visibility_off)
                          ),
                        ),
                      ),
                      Spacer(flex: 3,),
                      ElevatedButton(onPressed: () async {
                        if(formkey.currentState!.validate()){
                          var existinguser = await FirebaseFirestore.instance.collection('users').where('phone',isEqualTo: phone.text).get();
                          if(existinguser.docs.isNotEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Phone Number is already Registered')));
                            return;
                          }
                          await FirebaseAuth.instance.verifyPhoneNumber(
                              verificationCompleted: (
                                  PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseException ex) {},
                              codeSent: (String verificationid,
                                  int ? resendtoken) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        verifyOtpScreen(phone: phone.text.toString(),verificationid: verificationid,name: Name.text,password: password.text,
                                        ),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout: (
                                  String varificationid) {},
                              phoneNumber: phone.text.toString());
                        }


                      }, child: Text('SignUp'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)
                            )

                        ),),
                      Spacer(flex: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: () {
                            // if (formkey.currentState!.validate()) {}
                            Navigator.pop(context);
                          }, child: Text('back to Login',
                            style: TextStyle(color: Colors.white),))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenHeight * 0.08,),
          ],
        ),
      ),
    );;
  }
}
