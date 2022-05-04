import 'package:flutter/material.dart';
import 'package:gasworks/constants/route_names.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';
import '../../models/app_model.dart';

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
  final roomsList = locator<AppModel>();
  addRoomPressed() {}
  void saveContinuePressed() {
    _navigationService.navigateTo(AddAppliancesRoute);
  }

  noRooms(bool newValue) async {
    if (newValue == true && roomsList.roomsList.isNotEmpty) {
      var response = await _dialogService.showConfirmationDialog(
          title: "RoomList Is Not Empty",
          description:
              "Action will delete all items in RoomList. Are you sure you want to continue?",
          confirmationTitle: "Yes",
          cancelTitle: "No");
      if (response!.confirmed) {
        roomsList.roomsList.clear();
        noRoom = newValue;
      }
    } else {
      noRoom = newValue;
    }

    notifyListeners();
  }

  num stringToNumber(String input) {
    return num.tryParse(input)!;
  }

  Future<void> addToRoomList() async {
    if (roomNameController.text.isNotEmpty && area != 0) {
      roomsList.roomsList[roomNameController.text.trim()] = area;
      roomNameController.text = '';
      heightController.text = '';
      widthController.text = '';
      lengthController.text = '';
      area = 0.0;
      showAddroom = false;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
          title: "Validation Failed",
          description:
              "roomname length width and height cannot be empty  ..... Please try again ");
    }
  }

  void removeRoom(key) {
    roomsList.roomsList.remove(key);
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

  Future<void> checkAddRoom() async {
    height = stringToDouble_tryParse(heightController.text.trim())!;
    width = stringToDouble_tryParse(widthController.text.trim())!;
    length = stringToDouble_tryParse(lengthController.text.trim())!;

    if (height != 0 && width != 0 && length != 0) {
      area = height * width * length;
      showAddroom = true;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
          title: "Validation Failed",
          description:
              "length width and height cannot be empty  ..... Please enter again ");
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

  void addNA() {
    roomsList.roomsList['N/A'] = 0.0;
  }
}
