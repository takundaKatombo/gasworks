import 'package:flutter/material.dart';
import 'package:gasworks/models/base_view_model.dart';

class SolarSizingViewModel extends BaseViewmodel {
  int numberOfPanels = 0;

  double dailyPower = 0.0;
  double dailyConsumption = 0.0;
  double sunPeakHours = 0.0;
  double panelWatts = 0.0;

  final wpController = TextEditingController();

  final vdcController = TextEditingController();

  final chargingInputCurrentController = TextEditingController();

  final panelShortCircuitCurrentController = TextEditingController();

  final panelOpenCircuitVoltageController = TextEditingController();
  double panelShortCircuitCurrent = 0.0,
      vdc = 0.0,
      wp = 0.0,
      panelOpenCircuitVoltage = 0.0,
      maxPVPowerWatts = 0.0,
      minVdc = 0.0;

  final dailyConsumptionController = TextEditingController();

  final sunPeakHoursController = TextEditingController();

  final panelWattsController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> calcDailyPower() async {
    if (dailyConsumption != 0 && sunPeakHours != 0) {
      dailyPower = (dailyConsumption / sunPeakHours) * 1.3;
    }
  }

  Future<void> calcPanels() async {
    if (dailyPower != 0 && panelWatts != 0) {
      numberOfPanels = ((dailyPower * 1000) / panelWatts).ceil();
    }
  }

  Future<void> calc() async {
    await calcDailyPower();
    await calcPanels();
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

  void calcMaxPV() {
    maxPVPowerWatts = panelWatts * numberOfPanels;
  }

  void calcminVdc() {
    minVdc = panelOpenCircuitVoltage * numberOfPanels;
  }
}
