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
  bool showAddroom = true;
  num height = 0;
  num width = 0;
  num length = 0;
  String? roomName;
  num area = 0;
  Map roomsList = {'lounge': 70.0, 'kitchen': 50.0, 'dining': 40.0};
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
    roomsList['roomName'] = 50.0;
    roomName = '';
    height = 0;
    width = 0;
    length = 0;
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
    if (height != 0 && width != 0 && length != 0) {
      area = height * width * length;
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

  Future<void> showNotNumericDialog() async {
    await _dialogService.showDialog(
        title: "Please enter a numeric value",
        description: "Value Entered not numeric ... Please enter a number");
  }
}
