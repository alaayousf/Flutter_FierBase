import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'ListAlLItem.dart';
import 'Providerdata.dart';

class Insertdate extends StatefulWidget {
  @override
  _InsertdateState createState() => _InsertdateState();
}

class _InsertdateState extends State<Insertdate> {
  FirebaseFirestore fri;
  FirebaseStorage firebaseStorage;
  var name = '';
  var moNumper = '';
  @override
  void initState() {
    fri = FirebaseFirestore.instance;
    firebaseStorage = FirebaseStorage.instance;
    super.initState();
  }

  File _image;
  String imageUrl;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    var info = Provider.of<Providerdata>(context,);

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onChanged: (newVla) {
                this.name = newVla;
              },
              decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.7),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.7),
                  ),
                  hintText: 'Tell us about yourself',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  suffixStyle: const TextStyle(color: Colors.blue)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              onChanged: (newVla) {
                this.moNumper = newVla;
              },
              decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.7),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.7),
                  ),
                  hintText: 'Tell us about yourself',
                  prefixIcon: const Icon(
                    Icons.mobile_friendly_sharp,
                    color: Colors.blue,
                  ),
                  suffixStyle: const TextStyle(color: Colors.blue)),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white,
                  child: Text(
                    'Add Item',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    fri.collection('collectionPath').add(
                        {'name': '${this.name}', 'mobile': '${this.moNumper}'});

                    //fri.collection('collectionPath').doc('cnZ7MrDqtHzzgUlkIy3b').set({'name': 'Alaa', 'mobile': '0592689368'});
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.pink,
                  child: Text(
                    'Get All  Item',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LitAlLitem()),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                height: 100,
                child: _image != null
                    ? Image.file(
                        _image,
                      )
                    : Text('no Image Sellected')),

                 Container(
            width: double.infinity,
            height: 100,
            child:Image.network(
                   info.statecarde,
                  )
                ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: getImage,
            child: Icon(
              Icons.image,
              color: Colors.blue,
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.green,
            elevation: 0,
            onPressed: () async {
              var snapShote = await firebaseStorage
                  .ref()
                  .child('folderName/imageName${DateTime.now()}')
                  .putFile(_image)
                  .whenComplete(() => () {
                        print('UplodeFinash');
                      });
     var x = await snapShote.ref.getDownloadURL();
     info.setArray(x);
          
            },
            child: Icon(
              Icons.image,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
