import 'package:flutter/cupertino.dart';

class ProviderDate with ChangeNotifier {
  int _count;

  ProviderDate(this._count);

  void add() {
    _count++;
    notifyListeners(); //2
  }

  get count => _count;
}
