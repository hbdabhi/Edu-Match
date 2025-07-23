import 'package:firebase_demo/HomePage/homePageScreen/addUser.dart';
import 'package:firebase_demo/HomePage/homePageScreen/viewFavoriteUser/viewFavoriteStudent.dart';
import 'package:firebase_demo/HomePage/homePageScreen/viewUsers/viewUser_List.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    Size size = FocusScope.of(context).size;
    double ScreenHeight = size.height;
    double ScreenWidth = size.width;
    return Scaffold(
      appBar:AppBar(title:Text('Matrimonial',style: TextStyle(fontSize: ScreenWidth*0.07,color: Colors.blue[900],fontWeight: FontWeight.w700),),
      automaticallyImplyLeading: false,),
      body: GridView.count(
        crossAxisCount:2, padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
        mainAxisSpacing: ScreenHeight*0.05,
        crossAxisSpacing: ScreenWidth*0.09,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: ScreenWidth * 0.04,
                ),
              ],
              borderRadius: BorderRadius.circular(ScreenWidth * 0.050),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(ScreenWidth * 0.050),
              child: InkWell(
                splashColor: Colors.lightBlue[100],
                highlightColor: Colors.lightBlue[100],
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return
                        addUser();
                  },));
                },
                borderRadius: BorderRadius.circular(ScreenWidth * 0.050),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(ScreenWidth * 0.050),
                  ),
                  padding: EdgeInsets.all(ScreenWidth * 0.015),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: ScreenHeight * 0.025),
                      FaIcon(FontAwesomeIcons.pen, size: ScreenHeight * 0.08),
                      SizedBox(height: ScreenHeight * 0.025),
                      Text(
                        'Add User',
                        style: TextStyle(
                          fontSize: ScreenWidth * 0.05,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            // padding: EdgeInsets.all(ScreenWidth*0.015),
            decoration : BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: ScreenWidth * 0.04,
                ),
              ],
              borderRadius: BorderRadius.circular(ScreenWidth * 0.050),
            ),
            child:Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(ScreenWidth*0.050),
              child: InkWell(
                splashColor: Colors.lightBlue[100],
                highlightColor: Colors.lightBlue[100],
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return viewUser_List();
                  },));
                },
                borderRadius: BorderRadius.circular(ScreenWidth * 0.050),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(ScreenWidth*0.05)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenHeight*0.025,),
                      FaIcon(FontAwesomeIcons.clipboardList, size: ScreenHeight * 0.085),
                      SizedBox(height: ScreenHeight*0.025,),
                      Text('View User',style: TextStyle(fontSize: ScreenWidth*0.05,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration : BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black54,blurRadius: ScreenWidth*0.04)],
              borderRadius: BorderRadius.circular(ScreenWidth*0.050),

            ),
            child:Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(ScreenWidth*0.05),
              child: InkWell(
                splashColor: Colors.lightBlue[100],
                highlightColor: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(ScreenWidth*0.05),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return viewFaviroteStudent();
                  },));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(ScreenWidth*0.05)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenHeight*0.025,),
                      Icon(Icons.favorite,size: ScreenHeight*0.1,),
                      SizedBox(height: ScreenHeight*0.01,),
                      Text('Favorite User',style: TextStyle(fontSize: ScreenWidth*0.05,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(

            decoration : BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black54,blurRadius: ScreenWidth*0.04)],
              borderRadius: BorderRadius.circular(ScreenWidth*0.050),

            ),
            child:Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(0.05),
              child: InkWell(
                splashColor: Colors.lightBlue[100],
                highlightColor: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(ScreenWidth*0.05),
                onTap: (){},
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    border: BoxBorder.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(ScreenWidth*0.05)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenHeight*0.025,),
                      Icon(Icons.person,size: ScreenHeight*0.1,),
                      SizedBox(height: ScreenHeight*0.01,),
                      Text('About Us',style: TextStyle(fontSize: ScreenWidth*0.05,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],)
    );
  }
}
