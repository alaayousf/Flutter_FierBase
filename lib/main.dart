import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Authenticate.dart';
import 'package:provider/provider.dart';

import 'Providerdata.dart';


void main()   async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<Providerdata>(
      create: (BuildContext context) => Providerdata(statecarde:'https://i.pinimg.com/564x/f2/91/c9/f291c90fdfc64c1af854d80332365bff.jpg'),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:Authenticate(),
      ),
    );
  }
}
