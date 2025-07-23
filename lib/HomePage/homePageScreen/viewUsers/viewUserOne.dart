import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/HomePage/homePageScreen/viewUsers/editStudent.dart';
import 'package:flutter/material.dart';

class viewUserOne extends StatefulWidget {
  String Id;

  viewUserOne({super.key, required this.Id});

  @override
  State<viewUserOne> createState() => _viewUserOneState();
}

class _viewUserOneState extends State<viewUserOne> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    getStudent();
  }

  Future<void> getStudent() async {
    DocumentSnapshot std = await FirebaseFirestore.instance
        .collection('student')
        .doc(widget.Id)
        .get();
    if (std.exists) {
      Map<String, dynamic> studentdata = std.data() as Map<String, dynamic>;
      data = studentdata;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double Height = size.height;
    double Width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details '),
        automaticallyImplyLeading: false,
      ),
      body: data == null
          ? CircularProgressIndicator()
          : SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: BoxBorder.all(color: Colors.black),
                          shape: BoxShape.circle
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: Width * 0.1,
                          child: Icon(Icons.person, size: Width * 0.15),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Height * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Width * 0.03,
                      vertical: Height * 0.01,
                    ),
                    child: Container(
                      height: Height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: BoxBorder.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Width * 0.03),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Width * 0.04),
                          Text(
                            "Name : ",
                            style: TextStyle(
                              fontSize: Width * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data!['name'],
                            style: TextStyle(fontSize: Width * 0.045),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Width * 0.03,
                      vertical: Height * 0.01,
                    ),
                    child: Container(
                      height: Height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: BoxBorder.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Width * 0.03),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Width * 0.04),
                          Text(
                            "Mobile No : ",
                            style: TextStyle(
                              fontSize: Width * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data!['phone'].toString(),
                            style: TextStyle(fontSize: Width * 0.045),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Width * 0.03,
                      vertical: Height * 0.01,
                    ),
                    child: Container(
                      height: Height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: BoxBorder.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Width * 0.03),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Width * 0.04),
                          Text(
                            "E-mail: ",
                            style: TextStyle(
                              fontSize: Width * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data!['email'].toString(),
                            style: TextStyle(fontSize: Width * 0.045),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Width * 0.03,
                      vertical: Height * 0.01,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: BoxBorder.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Width * 0.03),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: Height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Width * 0.04,
                                height: Height * 0.05,
                              ),
                              SizedBox(
                                width: Width * 0.2,
                                child: Text(
                                  "Address : ",
                                  style: TextStyle(
                                    fontSize: Width * 0.045,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Width * 0.64,
                                child: Text(
                                  data!['address'],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: Width * 0.045),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Height * 0.015),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Width * 0.03,
                      vertical: Height * 0.01,
                    ),
                    child: Container(
                      height: Height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: BoxBorder.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Width * 0.03),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Width * 0.04),
                          Text(
                            "City:   ",
                            style: TextStyle(
                              fontSize: Width * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data!['city'],
                            style: TextStyle(fontSize: Width * 0.045),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Width * 0.03,
                      vertical: Height * 0.01,
                    ),
                    child: Container(
                      height: Height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: BoxBorder.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Width * 0.03),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Width * 0.04),
                          Text(
                            "Date of Birth :  ",
                            style: TextStyle(
                              fontSize: Width * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data!['dob'],
                            style: TextStyle(fontSize: Width * 0.045),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Width * 0.03,
                      vertical: Height * 0.01,
                    ),
                    child: Container(
                      height: Height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: BoxBorder.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Width * 0.03),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: Width * 0.04),
                          Text(
                            "Gender : ",
                            style: TextStyle(
                              fontSize: Width * 0.045,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            data!['gender'],
                            style: TextStyle(fontSize: Width * 0.045),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Width * 0.03,
                      vertical: Height * 0.01,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: BoxBorder.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(Width * 0.03),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: Height * 0.015),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Width * 0.04,
                                height: Height * 0.05,
                              ),
                              SizedBox(
                                width: Width * 0.2,
                                child: Text(
                                  "Hobbies : ",
                                  style: TextStyle(
                                    fontSize: Width * 0.045,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Width * 0.64,
                                child: Text(
                                  data!['hobbies'],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(fontSize: Width * 0.045),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Height * 0.015),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: Width*0.03,vertical: Height*0.01),
                    child: Container(
                      
                      child: Column(
                        children: [
                          SizedBox(height: Height*0.015,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) {
                                  return editStudent(Id: widget.Id, isFav: data!['isFavorite']);
                                },)).then((value) {
                                  setState(() {
                                  });
                                },);
                              },style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ), child: Text('  Edit  ',style: TextStyle(color: Colors.white),)),
                              ElevatedButton(onPressed: (){
                                showDeleteBox(context,widget.Id);
                              },style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                )
                              ), child: Text('Delete',style: TextStyle(color: Colors.white),)),
            
                            ],
                          ),
            
                          SizedBox(height: Height*0.015,),
                        ],
                      ),
                    ),
                  ),              ],
              ),
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
