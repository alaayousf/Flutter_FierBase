import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LitAlLitem extends StatefulWidget {
  @override
  _LitAlLitemState createState() => _LitAlLitemState();
}

class _LitAlLitemState extends State<LitAlLitem> {
  FirebaseFirestore query;
  @override
  void initState() {
    query = FirebaseFirestore.instance;
    super.initState();
    
  }
  //get data from Firebase

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: StreamBuilder<QuerySnapshot>(
              stream: query.collection('collectionPath').snapshots(),
              builder: (context, stream) {
                if (stream.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (stream.hasError) {
                  return Center(child: Text(stream.error.toString()));
                }

                QuerySnapshot querySnapshot = stream.data;

                return ListView.builder(
                  itemCount: querySnapshot.size,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(10.0),
                    padding:  const EdgeInsets.all(20.0),
                    
                    color: Colors.lightBlue,
                    child: Text('nnn:${querySnapshot.docs[index].data().values}',style:TextStyle(color: Colors.black,fontSize: 20),)),
                );
              },
            )),
        ),
      )
      
    );
  }
}
 