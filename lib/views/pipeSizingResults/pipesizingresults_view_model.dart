import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasworks/models/appliance_model.dart';

import '../../locator.dart';
import '../../models/app_model.dart';

class PipeSizingResultsViewModel extends ChangeNotifier {
  final roomsList = locator<AppModel>();
  List<Map<String, Segment>> lp = [];
  List<Map<String, Segment>> hp = [];
  List<dynamic> hpCsv = [];

  Future<void> getLpHpLists() async {
    print("in getHpLp Lists");
    await _loadCSV();
    print(hpCsv);
    for (var applianceModel in roomsList.appliances.values) {
      print('in appliance model for ');
      applianceModel.segments.forEach((key, value) {
        print(value.tdMu.toString() + applianceModel.tdMu.toString());
        value.tdMu = applianceModel.tdMu;
        var tempMap = {key: value};
        if (value.lineHpLp == 'lp') {
          print(tempMap);
          lp.add(tempMap);
        } else {
          hp.add(tempMap);
        }
      });
    }
    for (var item in hp) {
      // final key = '${item["Description"]}-${item["UoM"]}';

      // (uniqueItems[key] == null)
      //     ? uniqueItems[key] = item
      //     : uniqueItems[key]['Quantity'] += item['Quantity'];
    }
    notifyListeners();
  }

  Future<void> _loadCSV() async {
    final _rawData = await rootBundle.loadString("highpressure.csv");
    hpCsv = const CsvToListConverter().convert(_rawData);
  }
  //TODO:Calculate total demand per lp and hp segment (summation of total demand )
  //Select where keys are the same and reduce/fold list summing up all the total demands from all appliances going through segmenrt
}
