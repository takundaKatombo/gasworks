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
  Map<String, double> segments = {};
  Map<String, double> appliances = {};
  String deviceFlued = ''; //TODO:check if null
  String segmentLabel = '';
  double meters = 0;
  String roomName = 'N/A';
  final totalDemandController = TextEditingController();

  String tdUnit = '';

  String lineHpLp = '';

  final segmentLabelController = TextEditingController();

  double totalLength = 15.0;

  final lengthController =
      TextEditingController(); //TODO:Calculate total Length
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

  void deviceFluedSet(String val) {
    deviceFlued = val;
    notifyListeners();
  }

  void lineHpLpSet(String s) {
    lineHpLp = s;
    notifyListeners();
  }

  void onAddSegmentPressed() {
    //totalLength=calculateTotalLength();
    segments[segmentLabelController.text.trim()] =
        stringToDouble_tryParse(lengthController.text)!;
    notifyListeners();
  }

  void removeSegment(String key) {
    segments.remove(key);
    notifyListeners();
  }

  void clearFields() {
    // applianceNameController.text = '';
    // elbowsController.text = '';
    // bendsController.text = '';
    // teesController.text = '';
    // deviceFlued = '';

    // totalDemandController.text = '';
    segmentLabel = '';
    segmentLabelController.text = '';
    // tdUnit = '';
    lineHpLp = '';
    meters = 0;
    lengthController.text = '';
  }

  clearAllFields() {
    applianceNameController.text = '';
    elbowsController.text = '';
    bendsController.text = '';
    teesController.text = '';
    deviceFlued = '';

    totalDemandController.text = '';
    segmentLabel = '';
    segmentLabelController.text = '';
    tdUnit = '';
    lineHpLp = '';
    meters = 0;
    lengthController.text = '';
  }

  Future<void> showValidationFailed() async {
    await _dialogService.showDialog(
        title: "Validation Failed",
        description: "Please check values entered and try again ");
  }

  void saveApplianceAndAdd() {
    totalLength = calculateTotalLength();
    appliances[applianceNameController.text.trim()] = totalLength;
    clearAllFields();
    segments.clear();
    //TODO:add to appmodel
    notifyListeners();
  }

  double calculateTotalLength() {
    double? elbows = stringToDouble_tryParse(elbowsController.text),
        tees = stringToDouble_tryParse(teesController.text),
        bends = stringToDouble_tryParse(bendsController.text);
    double a = (elbows! * 0.8);
    double b = bends! * 0.6;
    double c = tees! * 0.8;
    double segmentLengths = 0;
    segments.values.forEach((element) {
      segmentLengths += element;
    });
    ;
    print(segmentLengths);
    print(" segmentlengths");
    print(a);
    print(" a");
    print(b);
    print("b");
    return segmentLengths + a + b + c;
  }
}
