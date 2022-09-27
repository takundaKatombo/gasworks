import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasworks/models/appliance_model.dart';
import "package:collection/collection.dart";
import '../../locator.dart';
import '../../models/app_model.dart';

class PipeSizingResultsViewModel extends ChangeNotifier {
  final roomsList = locator<AppModel>();
  List<Map<String, Segment>> lp = [];
  List<Map<String, Segment>> hp = [];
  // List<dynamic> hpCsv = [];
  List<Map<String, Segment>> reducedLP = [];
  List<Map<String, Segment>> reducedHP = [];

  Future<void> getLpHpLists() async {
    print("in getHpLp Lists");
    // await _loadCSV();
    // print(hpCsv);
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
    print(lp);
    for (var elementHP in hp) {
      String key = '';
      double td = 0;
      int index = -2;
      for (var element in elementHP.values) {
        td = element.tdMu;
      }
      for (var element in elementHP.keys) {
        key = element;
      }
      index = reducedHP.indexWhere((element) => element.keys.contains(key));
      if (index >= 0) {
        for (var element in reducedHP[index].values) {
          element.tdMu += td;
        }
      } else {
        reducedHP.add(elementHP);
      }
    }
    for (var elementLP in lp) {
      String key = '';
      double td = 0;
      int index = -2;
      for (var element in elementLP.values) {
        td = element.tdMu;
      }
      for (var element in elementLP.keys) {
        key = element;
      }
      index = reducedLP.indexWhere((element) => element.keys.contains(key));
      if (index >= 0) {
        for (var element in reducedLP[index].values) {
          element.tdMu += td;
        }
      } else {
        reducedLP.add(elementLP);
      }
//       for (var element in reducedLP[index].values) {             element.tdMu += td;
// }
//       for (var elementRLP in reducedLP) {
//         print('for in reduced lp');
//         if (elementRLP.containsKey(key)) {
//           print(elementRLP.values);
//           for (var elementFor in elementLP.values) {
//             elementFor.tdMu += td;
//           }
//         } else {
//           reducedLP.add(elementRLP);
//         }
//       }
    }
    //   reducedLP = groupBy(lp, (Map<String, Segment> e) {
    //     String key = '';
    //     for (var element in e.keys) {
    //       key = element;
    //     }
    //     return e[key]!.tdMu;
    //   })
    //       .values //TODO: use keys
    //       .map((e) => e.reduce((sum, e) {
    //             Segment valSeg = Segment(0, 'lp');
    //             double tdElement = 0, tdSum = 0;
    //             String key = '';
    //             for (var element in sum.values) {
    //               tdSum = element.tdMu;
    //             }
    //             for (var element in e.values) {
    //               tdElement = element.tdMu;
    //             }
    //             for (var element in e.keys) {
    //               key = element;
    //             }
    //             valSeg.tdMu = tdSum + tdElement;
    //             Map<String, Segment> val = {key: valSeg};
    //             return val;
    //           }))
    //       .toList();
    //   notifyListeners();
    // }

    // Future<void> _loadCSV() async {
    //   final _rawData = await rootBundle.loadString("highpressure.csv");
    //   hpCsv = const CsvToListConverter().convert(_rawData);
    // }
    //TODO:Calculate total demand per lp and hp segment (summation of total demand )
    //Select where keys are the same and reduce/fold list summing up all the total demands from all appliances going through segmenrt
  }
}
