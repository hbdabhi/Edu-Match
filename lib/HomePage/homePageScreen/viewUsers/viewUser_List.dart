import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/HomePage/homePageScreen/viewUsers/editStudent.dart';
import 'package:firebase_demo/HomePage/homePageScreen/viewUsers/viewUserOne.dart';
import 'package:flutter/material.dart';

class viewUser_List extends StatefulWidget {
  const viewUser_List({super.key});

  @override
  State<viewUser_List> createState() => _viewUser_ListState();
}

class _viewUser_ListState extends State<viewUser_List> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double Screenwidth = size.width;
    double ScreenHeight = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: ScreenHeight * 0.02),
          SizedBox(
            height: ScreenHeight * 0.065,
            width: Screenwidth * 0.95,
            child: SearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase(); // Case-insensitive search
                });
              },
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
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },

                ),
              ],
              elevation: MaterialStateProperty.all(0),
              // No box shadow
              backgroundColor: MaterialStateProperty.all(Color(0xFFCDCACB)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('student')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(value: 5,);
                }
                final data = snapshot.data!.docs;

                final filteredData = data.where((doc) {
                  final name = doc['name'].toString().toLowerCase();
                  final city = doc['city'].toString().toLowerCase();
                  final phone = doc['phone'].toString().toLowerCase();
                  final email = doc['email'].toString().toLowerCase();

                  return name.contains(_searchQuery) ||
                      city.contains(_searchQuery) ||
                      phone.contains(_searchQuery) ||
                      email.contains(_searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final student = filteredData[index];
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
                                          Text(student['name']),
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
                                          Text(student['city']),
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
                                          Text(student['phone'].toString()),
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
                                          Text(student['email']),
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
                                        bool _isfavorite = student['isFavorite']??false;
                                        return
                                      IconButton(

                                        onPressed: () async {
                                          print(student.id);
                                          print(student['isFavorite']);

                                          print(_isfavorite);
                                          await FirebaseFirestore.instance
                                              .collection('student')
                                              .doc(student.id)
                                              .update({
                                             'isFavorite':
                                                    !_isfavorite,
                                              });
                                          localSetState(() {
                                          });
                                        },
                                        icon: Icon(
                                          student['isFavorite']
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                        ),
                                      ); },),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return editStudent(Id: data[index].id,isFav: student['isFavorite'],);
                                          },));
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDeleteBox(context,student.id);
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
