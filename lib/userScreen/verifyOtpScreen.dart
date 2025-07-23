import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/HomePage/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class verifyOtpScreen extends StatefulWidget {
  String verificationid;
  String phone;
  String name;
  String password;

  verifyOtpScreen({
    super.key,
    required this.verificationid,
    required this.phone,
    required this.password,
    required this.name
  });

  @override
  State<verifyOtpScreen> createState() => _verifyOtpScreenState();
}

class _verifyOtpScreenState extends State<verifyOtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ScreenWidth = size.width;
    double ScreenHeight = size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: ScreenHeight * 0.1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            child: Text(
              'Validate your Account otp send on this Mobile No. ',
              style: TextStyle(fontSize: ScreenWidth * 0.05),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
                child: Text(
                  widget.phone,
                  style: TextStyle(fontSize: ScreenWidth * 0.038),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: ScreenHeight * 0.1,
                width: ScreenWidth * 0.15,
                child: TextField(
                  controller: _controllers[0],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              SizedBox(
                height: ScreenHeight * 0.1,
                width: ScreenWidth * 0.15,
                child: TextField(
                  controller: _controllers[1],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              SizedBox(
                height: ScreenHeight * 0.1,
                width: ScreenWidth * 0.15,
                child: TextField(
                  controller: _controllers[2],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              SizedBox(
                height: ScreenHeight * 0.1,
                width: ScreenWidth * 0.15,
                child: TextField(
                  controller: _controllers[3],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              SizedBox(
                height: ScreenHeight * 0.1,
                width: ScreenWidth * 0.15,
                child: TextField(
                  controller: _controllers[4],
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              SizedBox(
                height: ScreenHeight * 0.1,
                width: ScreenWidth * 0.15,
                child: TextField(
                  controller: _controllers[5],
                  onChanged: (value) {
                    if (value.length == 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ],
          ),
          isLoading
              ? CircularProgressIndicator()
              :
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(15),
              ),
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              try {
                PhoneAuthCredential credential =
                    await PhoneAuthProvider.credential(
                      verificationId: widget.verificationid,
                      smsCode: _controllers.map((c) => c.text).join(),);
                      FirebaseAuth.instance.signInWithCredential(credential).then((value){
                        RegisterUser(name: widget.name,phone: widget.phone,password: widget.password);
                      });
              } catch (ex) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(ex.toString()))
                );
              }finally {
                setState(() {
                  isLoading = false;
                });
              }

            },
            child: Text('Verify', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
  Future<void> RegisterUser ({
    required String name,
    required String phone,
    required String password,
  })async {
    try{
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'phone':phone,
        'password': password,
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Homepage();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Registered Successfully',style: TextStyle(color: Colors.green),)));

    }catch(ex){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.toString(),style: TextStyle(color: Colors.red),),));
    }
  }
}
