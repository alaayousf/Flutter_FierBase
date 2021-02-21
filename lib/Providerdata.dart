import 'package:flutter/material.dart';

class Providerdata extends ChangeNotifier{

    String statecarde;
Providerdata({@required this.statecarde});

void setArray(String value) {
  statecarde=value;
  notifyListeners();
}

}