import 'package:elaptop/models/user.dart';
import 'package:elaptop/screens/home.dart';
import 'package:elaptop/widgets/myButton.dart';
import 'package:elaptop/widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

bool isMale = true;

class _ProfileState extends State<Profile> {
  bool edit = false;
  File? _pickedImage;
  PickedFile? _image;
  Future<void> getImage({ImageSource? scource}) async {
    _image = (await ImagePicker().getImage(source: scource!))!;
    if (_image != null) {
      _pickedImage = File(_image!.path);
    }
  }

  Future<void> myDialogBox() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                    title: Text('Pick from camera'),
                    onTap: () {
                      getImage(scource: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: Colors.black,
                    ),
                    title: Text('Pick from gallary'),
                    onTap: () {
                      getImage(scource: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _uploadImage({File? image}) async {
    User user = FirebaseAuth.instance.currentUser!;
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("userimage/${user.uid}" + DateTime.now().toString());
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask.then((res) {
      res.ref.getDownloadURL();
    });
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser!;
    List<UserModel> snapShot =
        Provider.of<List<UserModel>>(context, listen: true);
    List<UserModel> user =
        snapShot.where((element) => element.userId == currentUser.uid).toList();

    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: Icon(Icons.close, color: Colors.black38, size: 30),
                onPressed: () {
                  setState(() {
                    edit = !edit;
                  });
                },
              )
            : IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: Home()),
                  );
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
        backgroundColor: Colors.white,
        actions: [
          edit == false
              ? NotificationButton()
              : Row(
                  children: [
                    Text('Save'),
                    IconButton(
                      icon: Icon(Icons.check, size: 30, color: Colors.blue),
                      onPressed: () {
                        _uploadImage(image: _pickedImage);
                        setState(() {
                          //todo: save user
                          edit = !edit;
                        });
                      },
                    )
                  ],
                ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: MediaQuery.of(context).size.height * (710 / 812),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  //*image info
                  Stack(
                    children: [
                      Container(
                        height: 130,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              maxRadius: 65,
                              backgroundImage: _pickedImage == null
                                  ? AssetImage('assets/userImage.png')
                                      as ImageProvider
                                  : FileImage(_pickedImage!),
                            ),
                          ],
                        ),
                      ),
                      edit == true
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 215, top: 80),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: GestureDetector(
                                  onTap: () {
                                    // myDialogBox();
                                    getImage(scource: ImageSource.gallery);
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      // Icons.camera_alt,
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  //*
                  Container(
                    height: 400,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //*info here
                        Container(
                          height: 380,
                          child: edit == true
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildTextFormField(
                                        enable: false,
                                        name: user.length > 0
                                            ? user[0].userName
                                            : ''),
                                    _buildTextFormField(
                                        enable: true,
                                        name: user.length > 0
                                            ? user[0].userEmail
                                            : ''),
                                    //*Gender
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isMale = !isMale;
                                        });
                                      },
                                      child: Container(
                                        height: 60,
                                        padding: EdgeInsets.only(left: 10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                isMale == true
                                                    ? "Male"
                                                    : "Female",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    //*
                                    _buildTextFormField(
                                        enable: false,
                                        name: user.length > 0
                                            ? user[0].address == ''
                                                ? 'Input address . . .'
                                                : user[0].address
                                            : ''),
                                    _buildTextFormField(
                                        enable: false,
                                        name: user.length > 0
                                            ? user[0].userPhoneNumber
                                            : ''),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildSingleContainer(
                                        start: 'Name',
                                        end: user.length > 0
                                            ? user[0].userName
                                            : ''),
                                    _buildSingleContainer(
                                        start: 'Email',
                                        end: user.length > 0
                                            ? user[0].userEmail
                                            : ''),
                                    _buildSingleContainer(
                                        start: 'Address',
                                        end: user.length > 0
                                            ? user[0].address == ''
                                                ? 'Input address . . .'
                                                : user[0].address
                                            : ''),
                                    _buildSingleContainer(
                                        start: 'Gender',
                                        end: user.length > 0
                                            ? user[0].userGender
                                            : ''),
                                    _buildSingleContainer(
                                        start: 'Phone',
                                        end: user.length > 0
                                            ? user[0].userPhoneNumber
                                            : ''),
                                  ],
                                ),
                        ),
                        //*
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: edit == false
                        ? MyButton(
                            onPressed: () {
                              setState(() {
                                this.edit = !this.edit;
                              });
                            },
                            name: 'Edit Profile',
                          )
                        : Container(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleContainer({String? start, String? end}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              start!,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black45,
              ),
            ),
            end == 'Input address . . .'
                ? Text(
                    'Input address . . .',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  )
                : Text(
                    end!,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({String? name, bool? enable}) {
    return TextFormField(
      readOnly: enable!,
      decoration: InputDecoration(
        hintText: name!,
        hintStyle: TextStyle(
            color:
                name == 'Input address . . .' ? Colors.black26 : Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
