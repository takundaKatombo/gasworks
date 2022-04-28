import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';
import '../../models/app_model.dart';

class AddApplianceViewModel extends ChangeNotifier {
  final DialogService _dialogService = locator<DialogService>();
  final roomsList = locator<AppModel>();

  final GlobalKey<FormState> formKey = GlobalKey();
  final applianceNameController = TextEditingController();
  final teesController = TextEditingController();
  final elbowsController = TextEditingController();
  final bendsController = TextEditingController();
  double totalDemand = 0;
  Map segments = {};
  Map appliances = {};
  bool? deviceFlued; //TODO:check if null
  String segmentLabel = '';
  double meters = 0;
  String roomName = 'test';
  var totalDemandController;

  String tdUnit = '';

  String lineHpLp = '';

  final segmentLabelController = TextEditingController();

  double totalLength = 15.0; //TODO:Calculate total Length
  bool isNumericUsingRegularExpression(String string) {
    print("in isnumeric");
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  double? stringToDouble_tryParse(String input) {
    print('in stringtodouble');
    return double.tryParse(input);
  }

  Future<void> showRules() async {
    await _dialogService.showDialog(
        title: "Rule Container ", description: "To be edited ");
  }

  void tdUnitSet(String val) {
    tdUnit = val;
    notifyListeners();
  }

  void deviceFluedSet(bool bool) {
    deviceFlued = bool;
    notifyListeners();
  }

  void lineHpLpSet(String s) {
    lineHpLp = s;
    notifyListeners();
  }

  void onAddSegmentPressed() {
    segments[segmentLabelController.text.capitalize!.trim()] = meters;
    appliances[applianceNameController.text.trim()] = totalLength;
    notifyListeners();
  }

  void removeSegment(String key) {
    segments.remove(key);
    notifyListeners();
  }
}
