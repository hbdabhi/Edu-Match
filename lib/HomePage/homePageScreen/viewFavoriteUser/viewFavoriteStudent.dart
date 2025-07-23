import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../viewUsers/editStudent.dart';
import '../viewUsers/viewUserOne.dart';

class viewFaviroteStudent extends StatefulWidget {
  const viewFaviroteStudent({super.key});

  @override
  State<viewFaviroteStudent> createState() => _viewFaviroteStudentState();
}

class _viewFaviroteStudentState extends State<viewFaviroteStudent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double Screenwidth = size.width;
    double ScreenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Student List'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: ScreenHeight * 0.02),
          SizedBox(
            height: ScreenHeight * 0.065,
            width: Screenwidth * 0.95,
            child: SearchBar(
              hintText: 'Search...',
              textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14), // Smaller font
              ),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ), // Inside padding
              ),
              leading: Icon(Icons.search, size: 20),
              trailing: [
                IconButton(
                  icon: Icon(Icons.clear, size: 20),
                  onPressed: () {
                    // Clear logic here
                  },
                ),
              ],
              elevation: MaterialStateProperty.all(0),
              // No box shadow
              backgroundColor: MaterialStateProperty.all(Color(0xFFCDCACB)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onChanged: (value) {
                // handle search text here
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('student').where("isFavorite" ,isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final data = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Screenwidth * 0.05,
                        horizontal: ScreenHeight * 0.015,
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return
                              viewUserOne(Id: data[index].id,);
                          },));
                        },
                        child: Ink(
                          child: Container(
                            height: ScreenHeight * 0.185,
                            width: Screenwidth * 0.9,
                            decoration: BoxDecoration(
                              color: Color(0xFFE3E0E3),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: Screenwidth * 0.746,
                                  child: Column(
                                    children: [
                                      SizedBox(height: ScreenHeight * 0.015),
                                      Row(
                                        children: [
                                          SizedBox(width: Screenwidth * 0.04),
                                          Icon(
                                            Icons.person,
                                            size: ScreenHeight * 0.025,
                                          ),
                                          SizedBox(width: Screenwidth * 0.02),
                                          Text(data[index]['name']),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          SizedBox(width: Screenwidth * 0.04),
                                          Icon(
                                            Icons.location_city_outlined,
                                            size: ScreenHeight * 0.025,
                                          ),
                                          SizedBox(width: Screenwidth * 0.02),
                                          Text(data[index]['city']),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          SizedBox(width: Screenwidth * 0.04),
                                          Icon(
                                            Icons.phone_android,
                                            size: ScreenHeight * 0.025,
                                          ),
                                          SizedBox(width: Screenwidth * 0.02),
                                          Text(data[index]['phone'].toString()),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          SizedBox(width: Screenwidth * 0.04),
                                          Icon(
                                            Icons.email_outlined,
                                            size: ScreenHeight * 0.025,
                                          ),
                                          SizedBox(width: Screenwidth * 0.02),
                                          Text(data[index]['email']),
                                        ],
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Screenwidth * 0.18,
                                  child: Column(
                                    children: [
                                      StatefulBuilder(builder: (context , localSetState) {
                                        bool _isfavorite = data[index]['isFavorite']??false;
                                        return
                                          IconButton(

                                            onPressed: () async {
                                              print(data[index].id);
                                              print(data[index]['isFavorite']);

                                              print(_isfavorite);
                                              await FirebaseFirestore.instance
                                                  .collection('student')
                                                  .doc(data[index].id)
                                                  .update({
                                                'isFavorite':
                                                !_isfavorite,
                                              });
                                              localSetState(() {
                                              });
                                            },
                                            icon: Icon(
                                              data[index]['isFavorite']
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                            ),
                                          ); },),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return editStudent(Id: data[index].id,isFav: data[index]['isFavorite'],);
                                          },));
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDeleteBox(context,data[index].id);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  void showDeleteBox(BuildContext context, String Id ){
    showDialog(context: context, builder: (context) {
      return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Delete',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
              GestureDetector(onTap: ()async{
                await FirebaseFirestore.instance.collection('student').doc(Id).delete();
                Navigator.pop(context);
                SnackBar(content: Text('Record Deleted SuccessFully'),);
              },
                child: Text('yes',style: TextStyle(color: Colors.purple,fontSize: 16,fontWeight:FontWeight.w500),),),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text('no',style: TextStyle(color: Colors.purple,fontSize: 16,fontWeight:FontWeight.w500),),),



            ],)],
        ),
      ),);
    },);
  }
  }

