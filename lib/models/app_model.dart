import 'package:gasworks/models/appliance_model.dart';

class AppModel {
  Map roomsList = {};
  Map<String, ApplianceModel> appliances = {};
  ApplianceModel longestDistanceHp = ApplianceModel();
  ApplianceModel longestDistanceLp = ApplianceModel();
}
