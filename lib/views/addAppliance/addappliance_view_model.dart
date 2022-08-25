import 'package:flutter/material.dart';
import 'package:gasworks/constants/route_names.dart';
import 'package:gasworks/models/appliance_model.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';
import '../../models/app_model.dart';

class AddApplianceViewModel extends ChangeNotifier {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final roomsList = locator<AppModel>();
  ApplianceModel thisAppliance = ApplianceModel();
  final GlobalKey<FormState> formKey = GlobalKey();
  final applianceNameController = TextEditingController();
  final teesController = TextEditingController();
  final elbowsController = TextEditingController();
  final bendsController = TextEditingController();

  final totalDemandController = TextEditingController();

  final segmentLabelController = TextEditingController();

  final metersController = TextEditingController();

  String lineHpLp = ''; //TODO:Calculate total Length
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
    thisAppliance.tdUnit = val;
    if (val == 'kg') {
      thisAppliance.tdKG = stringToDouble_tryParse(totalDemandController.text)!;
      thisAppliance.tdMu = thisAppliance.tdKG * 50;
    } else {
      thisAppliance.tdMu = stringToDouble_tryParse(totalDemandController.text)!;
      thisAppliance.tdKG = thisAppliance.tdMu / 50;
    }
    // thisAppliance.td
    notifyListeners();
  }

  void deviceFluedSet(String val) {
    thisAppliance.deviceFlued = val;
    notifyListeners();
  }

  void lineHpLpSet(String s) {
    lineHpLp = s;
    notifyListeners();
  }

  Future<void> onAddSegmentPressed() async {
    //totalLength=calculateTotalLength();

    //   for (var element in roomsList.appliances.values) {
    //     if (element.segments.containsKey(segmentLabelController.text.trim())) {
    //       if (element.segments[segmentLabelController.text.trim()] == stringToDouble_tryParse(metersController.text.trim())) {
    //       //print
    //     } else {
    //       }
    //     } else {

    //   }
    // }
    // if (thisAppliance.segments.keys
    //         .contains()) &&
    //     (thisAppliance.segments[segmentLabelController.text.trim()] ==
    //         stringToDouble_tryParse(metersController.text.trim()))) {

    // } else {

    // }
    Iterable<MapEntry<String, Segment>> diffLengths = [];
    var segmentValidate = roomsList.appliances.values.where((element) =>
        element.segments.containsKey(segmentLabelController.text.trim()));
    print('seg valiudate' + segmentValidate.toString());
    for (var element in segmentValidate) {
      diffLengths = element.segments.entries.where((element) =>
          element.value.segmentMeters !=
          stringToDouble_tryParse(metersController.text.trim())!);
    }
    print('diff lenghts' + diffLengths.toString());
    if (diffLengths.isNotEmpty) {
      await _dialogService.showDialog(
          title: 'Segment Exits',
          description:
              'Another Segment With Same Name, On the Same Run And with Different Length Exists');
    } else {
      thisAppliance.segments[segmentLabelController.text.trim()] =
          Segment(0, lineHpLp);
      thisAppliance.segments[segmentLabelController.text.trim()]!
          .segmentMeters = stringToDouble_tryParse(metersController.text)!;
      thisAppliance.segments[segmentLabelController.text.trim()]!.lineHpLp =
          lineHpLp;
      notifyListeners();
    }
  }

  void removeSegment(String key) {
    thisAppliance.segments.remove(key);
    notifyListeners();
  }

  void clearFields() {
    // applianceNameController.text = '';
    // elbowsController.text = '';
    // bendsController.text = '';
    // teesController.text = '';
    // deviceFlued = '';

    // totalDemandController.text = '';
    thisAppliance.segmentLabel = '';
    segmentLabelController.text = '';
    // tdUnit = '';
    lineHpLp = '';
    metersController.text = '';
  }

  clearAllFields() {
    applianceNameController.text = '';
    elbowsController.text = '';
    bendsController.text = '';
    teesController.text = '';
    totalDemandController.text = '';
    segmentLabelController.text = '';
    thisAppliance = ApplianceModel();
  }

  Future<void> showValidationFailed() async {
    await _dialogService.showDialog(
        title: "Validation Failed",
        description: "Please check values entered and try again ");
  }

  void saveApplianceAndAdd() {
    thisAppliance.totalLength = calculateTotalLength();
    roomsList.appliances[applianceNameController.text.trim()] = thisAppliance;
    clearAllFields();
    thisAppliance.segments.clear();
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
    for (var element in thisAppliance.segments.values) {
      segmentLengths += element.segmentMeters;
    }

    print(segmentLengths);
    print(" segmentlengths");
    print(a);
    print(" a");
    print(b);
    print("b");
    return segmentLengths + a + b + c;
  }

  void saveApplianceAndContinue() {
    thisAppliance.totalLength = calculateTotalLength();
    double tempHp = roomsList.appliances.values.first.totalLength;
    double tempLp = roomsList.appliances.values.first.totalLength;

    roomsList.appliances[applianceNameController.text.trim()] = thisAppliance;
    roomsList.appliances.forEach((key, value) {
      tempHp = tempHp > value.totalLength ? tempHp : value.totalLength;
      tempLp = tempLp > value.totalLength ? tempLp : value.totalLength;
    });
    _navigationService.navigateTo(PipeSizingResultsRoute);
  }
}
