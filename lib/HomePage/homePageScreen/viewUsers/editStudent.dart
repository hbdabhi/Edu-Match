import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class editStudent extends StatefulWidget {
  String Id;
  editStudent({super.key,required this.Id,required this.isFav});
  bool isFav;

  @override
  State<editStudent> createState() => _editStudentState();
}

class _editStudentState extends State<editStudent> {
  @override
  void initState() {
    super.initState();
    getStudent();
  }

  List<String> CityList = ['Ahmedabad', 'Botad', 'Rajkot', 'Surat', 'Vadodara'];
  String? selectedcity;
  String? selectedgender;

  List<String> hobbies = [
    'Cricket',
    'Football',
    'Reading',
    'Music',
    'Dance',
    'Traveling',
  ];

  Map<String, bool> selectedHobbies = {
    'Cricket': false,
    'Football': false,
    'Reading': false,
    'Music': false,
    'Dance': false,
    'Traveling': false,
  };
  Map<String, dynamic>? data;
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> getStudent() async {
    DocumentSnapshot std = await FirebaseFirestore.instance
        .collection('student')
        .doc(widget.Id)
        .get();
    if (std.exists) {
      Map<String, dynamic> studentdata = std.data() as Map<String, dynamic>;
      data = studentdata;
      name.text = data!['name'];
      address.text = data!['address'];
      phone.text = data!['phone'].toString(); // integer to string
      email.text = data!['email'];
      dob.text = data!['dob'];
      selectedcity = data!['city'];
      selectedgender = data!['gender'];

      // For hobbies
      List<String> studentHobbies = data!['hobbies'].split(', ');
      for (var hobby in hobbies) {
        selectedHobbies[hobby] = studentHobbies.contains(hobby);
      }
      setState(() {});
    }
  }

  Future<void> addStudent(
      String name,
      String address,
      int phone,
      String email,
      String city,
      String dob,
      String gender,
      String hobbies,
      ) async {
    try {
      final student = await FirebaseFirestore.instance
          .collection('student').doc(widget.Id)
          .update({
        'name': name,
        'address': address,
        'phone': phone,
        'email': email,
        'city': city,
        'dob': dob,
        'gender': gender,
        'hobbies': hobbies,
        'isFavorite': widget.isFav,
      });
      Navigator.pop(context);
      SnackBar(content: Text('Student Updated Successfully'),);
    }
    catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double ScreenHight = size.height;
    double ScrennWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Student Details"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ScrennWidth * 0.03),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: ScreenHight * 0.03),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is Required";
                    }
                    return null;
                  },
                  controller: name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Enter a Name',
                  ),
                ),
                SizedBox(height: ScreenHight * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Address is Required";
                    }
                    return null;
                  },
                  controller: address,
                  maxLines: 3,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home),
                    labelText: 'Enter Address',
                  ),
                ),
                SizedBox(height: ScreenHight * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Number is Required";
                    }
                    if (value.length != 10) {
                      return "phone number is 10 numbers";
                    }
                    return null;
                  },
                  controller: phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    labelText: 'Enter Mobile No.',
                  ),
                ),
                SizedBox(height: ScreenHight * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "E-mail is Required";
                    }
                    return null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    labelText: 'Enter E-mail ID',
                  ),
                ),
                SizedBox(height: ScreenHight * 0.02),
                DropdownButtonFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select a city ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Select City',
                    prefixIcon: Icon(Icons.location_city_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  value: selectedcity,
                  items: CityList.map((String city) {
                    return DropdownMenuItem(value: city, child: Text(city));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedcity = newValue!;
                    });
                  },
                ),
                SizedBox(height: ScreenHight * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select a Date of Birth is Required";
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      dob.text = date.toString().split(" ")[0];
                    }
                  },
                  controller: dob,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    labelText: 'Enter a Date of Birth',
                  ),
                ),
                SizedBox(height: ScreenHight * 0.02),
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.grey[300],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenHight * 0.015),
                      Row(
                        children: [
                          SizedBox(width: ScrennWidth * 0.04),
                          FaIcon(Icons.circle, size: ScrennWidth * 0.03),
                          SizedBox(width: ScrennWidth * 0.07),
                          Text(
                            'Select Gender',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: ScrennWidth * 0.043,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text('Male'),
                              value: 'Male',
                              groupValue: selectedgender,
                              onChanged: (value) {
                                setState(() {
                                  selectedgender = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text('Fe-Male'),
                              value: 'Fe-Male',
                              groupValue: selectedgender,
                              onChanged: (value) {
                                setState(() {
                                  selectedgender = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenHight * 0.02),
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.grey[300],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenHight * 0.02),
                      Row(
                        children: [
                          SizedBox(width: ScrennWidth * 0.04),
                          FaIcon(Icons.check_box, size: ScrennWidth * 0.06),
                          SizedBox(width: ScrennWidth * 0.04),
                          Text(
                            'Select Hobby',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: ScrennWidth * 0.043,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenHight * 0.02),
                      SizedBox(
                        height: ScreenHight * 0.18,
                        width: ScrennWidth * 0.9,
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 4,
                          // makes each row look like a checkbox row
                          children: hobbies.map((hobby) {
                            return Row(
                              children: [
                                Checkbox(
                                  value: selectedHobbies[hobby],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedHobbies[hobby] = value!;
                                    });
                                  },
                                ),
                                Text(hobby),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenHight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String N= name.text;
                          String A=address.text;
                          int P = int.parse(phone.text);
                          String E = email.text;
                          String C = selectedcity!;
                          String D = dob.text;
                          String G = selectedgender!;

                          List<String> selected = selectedHobbies.entries
                              .where((entry) => entry.value) // sirf true wale
                              .map((entry) => entry.key)     // unke naam
                              .toList();
                          String H = selected.join(', ');
                          addStudent(N,A,P,E,C,D,G,H);
                        }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Reset'),
                    ),
                  ],
                ),
                SizedBox(height: ScreenHight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
