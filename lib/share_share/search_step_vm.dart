import 'package:flutter/material.dart';
abstract class SearchStepVM extends ChangeNotifier{
  closeTask();
  updateTitle();
}

class PickSearchStepVM extends SearchStepVM{
  PickSearchStepVM(this.context);
  final BuildContext context;

  String title = 'default1';
  void initialise() {
    title = 'initialised';
    notifyListeners();
  }

  int counter = 0;

  @override
  void updateTitle() {
    counter++;
    title = '$counter';
    notifyListeners();
  }

  initSteps() {
    title = 'initialised';
    notifyListeners();
  }

  @override
  closeTask() async {
    counter++;
    title = '$counter';
    notifyListeners();
  }

  forceCloseTask() async {

  }
}