import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/HomePage/Homepage.dart';
import 'package:firebase_demo/userScreen/SignUpPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _ispass = true;
  bool _isLoding = false;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ScreenHeight = size.height;
    double ScreenWidth = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: ScreenHeight*0.16,),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(ScreenWidth*0.05),
                    child: Column(
                      children: [
                        Text('WELCOME TO MATRIMONY ',style: TextStyle(fontSize: ScreenWidth*0.07,color: Colors.teal[800],fontWeight: FontWeight.w800),),
                        Text('APPLICATION',style: TextStyle(fontSize: ScreenWidth*0.07,color: Colors.teal[800],fontWeight: FontWeight.w800),),
        
                      ],
                    ),
                  ),
                ),
            SizedBox(height: ScreenHeight*0.06,),
            Center(
              child: Container(
                padding: EdgeInsets.all(ScreenWidth*0.015),
                height: ScreenHeight*0.45,
                width: ScreenWidth*0.87,
                decoration : BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black54,blurRadius: ScreenWidth*0.04)],
                  border: BoxBorder.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(ScreenWidth*0.050),
                  gradient: LinearGradient(colors: [Colors.teal,Colors.tealAccent],
                  begin: Alignment.bottomRight,
                    end: Alignment.topLeft
                  )
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Spacer(flex: 3,),
                      Text('Login your Account',style: TextStyle(fontSize: ScreenWidth*0.07,color: Colors.black87,fontWeight: FontWeight.w800),),
                      Spacer(flex: 6,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Number is Required";
                          }
                          return null;
                        },
                        controller: userName,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter Phone',
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
                            hintText: 'Enter Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(onPressed: (){
                              print(_ispass);
                              setState(() {
                                _ispass = !_ispass;
                              });
                            }, icon: Icon(_ispass?Icons.visibility:Icons.visibility_off)
                            ),
                        ),
                      ),
                      // SizedBox(height: ScreenHeight*0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){}, child: Text('Forget Password?',style: TextStyle(color: Colors.blue[900]),))
                        ],
                      ),
                      _isLoding? CircularProgressIndicator():
                      ElevatedButton(onPressed: () async {
                        try {
                          if (formkey.currentState!.validate()) {
                            _isLoding = true;
                            setState(() {
                            });
                            var existinguser = await FirebaseFirestore.instance
                                .collection('users')
                                .where('phone', isEqualTo: "+91${userName.text}")
                                .where('password', isEqualTo: password.text)
                                .get();
                            _isLoding = false;
                            setState(() {
                            });

                            if (existinguser.docs.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Invalid phone number or password')),
                              );
                              return;
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Homepage();
                            },));

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Login Successfully')),
                            );
                          }
                        } catch (ex) {
                          print("Error: $ex");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Something went wrong')),
                          );
                        }
                      }, child: Text('Login'),
                        style: ElevatedButton.styleFrom(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                            )

                        ),),
                      Spacer(flex: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('for new user'),
                          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return
                              SignUpPage();
                          },));}, child: Text('click hear',style: TextStyle(color: Colors.white),))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: ScreenHeight*0.07,),
          ],
        ),
      ),
    );
  }
}
