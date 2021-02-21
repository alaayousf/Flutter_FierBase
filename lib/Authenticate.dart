import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Insertdate.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  FirebaseAuth auth;

  String emaile;
  String passworde;
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
        ),
      ),
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) {
              setState(() {
                this.emaile = val;
              });
            },
          ),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            onChanged: (val) {
              setState(() {
                this.passworde = val;
              });
            },
          ),
          RaisedButton(
              child: Text("Sin in"),
              color: Colors.green,
              onPressed: () async {
                var result = await auth.signInWithEmailAndPassword(
                    email: this.emaile.trim(), password: this.passworde.trim());

                if (result.user.uid != null) {
                  print('${result.user.uid}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Insertdate()),
                  );
                }
              }),
          RaisedButton(
              child: Text("Cearte"),
              color: Colors.yellowAccent,
              onPressed: () async {
                var result = await auth.createUserWithEmailAndPassword(
                    email: this.emaile, password: this.passworde);
                    
                if (result.user.uid != null) {
                  print('${result.user.uid}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Insertdate()),
                  );
                }
              })
        ],
      ),
    );
  }
}
