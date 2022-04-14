import 'package:flutter/material.dart';
import 'package:gasworks/constants/route_names.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class AddRoomsViewModel extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final GlobalKey<FormState> formKey = GlobalKey();
  final roomNameController = TextEditingController();
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final heightController = TextEditingController();
  bool noRoom = false;
  bool showAddroom = false;
  num height = 0;
  num width = 0;
  num length = 0;
  String? roomName;
  num area = 0;
  Map roomsList = {};
  addRoomPressed() {}
  void saveContinuePressed() {
    _navigationService.navigateTo(AddAppliancesRoute);
  }

  noRooms(bool newValue) {
    noRoom = newValue;
    notifyListeners();
  }

  num stringToNumber(String input) {
    return num.tryParse(input)!;
  }

  void addToRoomList() {
    roomsList[roomNameController.text.trim()] = area;
    roomNameController.text = '';
    heightController.text = '';
    widthController.text = '';
    lengthController.text = '';
    area = 0.0;
    notifyListeners();
  }

  void removeRoom(key) {
    roomsList.remove(key);
    notifyListeners();
  }

  bool isNumericUsingRegularExpression(String string) {
    print("in isnumeric");
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  double? stringToDouble_tryParse(String input) {
    print('in stringtodouble');
    return double.tryParse(input);
  }

  void checkAddRoom() {
    height = stringToDouble_tryParse(heightController.text.trim())!;
    width = stringToDouble_tryParse(widthController.text.trim())!;
    length = stringToDouble_tryParse(lengthController.text.trim())!;

    if (height != 0 && width != 0 && length != 0) {
      area = height * width * length;
      showAddroom = true;
      notifyListeners();
    }
  }

  void validateRoomName(String? value) {
    roomName = value!;
  }

  void validateLength(String value) {
    length = stringToNumber(value);
  }

  void validateWidth(String value) {
    height = stringToNumber(value);
  }

  void validateHeight(String value) {
    width = stringToNumber(value);
    checkAddRoom();
  }

  Future<void> showFailedValidation() async {
    await _dialogService.showDialog(
        title: "Validation Failed",
        description:
            "Either length width or height is not a number ..... Please enter again ");
  }
}
