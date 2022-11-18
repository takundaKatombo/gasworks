import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasworks/models/appliance_model.dart';
import 'package:fast_csv/fast_csv.dart' as _fast_csv;
import '../../locator.dart';
import '../../models/app_model.dart';

class PipeSizingResultsViewModel extends ChangeNotifier {
  final roomsList = locator<AppModel>();
  List<Map<String, Segment>> lp = [];
  List<Map<String, Segment>> hp = [];
  // List<dynamic> hpCsv = [];
  List<Map<String, Segment>> reducedLP = [];
  List<Map<String, Segment>> reducedHP = [];
  List<List<dynamic>> hpCsv = [];
  List<List<dynamic>> lpCsv = [];
  double lpIndexLength = 0;
  var hpIndexLength = 0.0;
  late List lpRow;
  late List hpRow;
  var tableTDRefIndexLP = 0;
  var tableTDRefIndexHP = 0;

  static const lowpressure = '''index length,9.5,15,22,28
3,48,199,495,1057
6,33,237,340,726
9,27,110,273,583
12,22,94,233,499
15,20,84,207,442
18,18,75,188,401
21,17,70,173,369
24,16,65,161,343
27,15,60,151,322
30,14,57,142,304
38,12,51,126,269
45,11,47,114,244
53,N/A,42,105,225
60,N/A,39,98,209
75,N/A,35,87,186
90,N/A,32,78,167''';
  final highpressure = '''indexlength,9.5,15,22,28
3,544,2279,5650,12084
6,373,1569,3890,8300
9,300,1261,3116,6667
12,257,1081,2671,5703
15,228,955,2364,5056
18,206,865,2141,4579
21,190,796,1972,4219
24,176,741,1834,3922
27,165,694,1728,3678
30,156,656,1632,3477
38,139,582,1442,3085
45,125,527,1304,2788
53,116,484,1198,2565
60,107,452,1124,2385
75,95,400,991,2120
90,86,363,898,1919''';

  double stringToDoubleTryParse(String input) {
    print('in stringtodouble');
    double? fromString = 0;
    fromString = double.tryParse(input);
    return fromString ?? -2.0;
  }

  num stringToIntTryParse(String input) {
    print('in stringtoint: passed value is ' + input);
    num? fromString = 0;
    fromString = num.tryParse(input);
    return fromString ?? -2;
  }

  void getIndexLengths() {
    for (final row in lpCsv) {
      if (row[0] != 'indexlength') {
        if (roomsList.longestDistanceLp.totalLength >=
            stringToDoubleTryParse(row[0])) {
          continue;
        } else {
          lpIndexLength = stringToDoubleTryParse(row[0]);
          lpRow = row;
          break;
        }
      } else {
        continue;
      }
    }
    for (final row in hpCsv) {
      if (row[0] != 'indexlength') {
        if (roomsList.longestDistanceHp.totalLength >=
            stringToDoubleTryParse(row[0])) {
          continue;
        } else {
          hpIndexLength = stringToDoubleTryParse(row[0]);
          hpRow = row;
          break;
        }
      } else {
        continue;
      }
    }
  }

  String getCopperSizeLp(String value) {
    print("value coppersizelp :" + value);
    var retVal = '';
    double valFromString = stringToDoubleTryParse(value);
    int column = 0;

    // for (var row in lpCsv) {
    //   if (row[0] != 'indexlength' &&
    //       stringToDoubleTryParse(row[0]) == lpIndexLength) {
    //     for (int counter = 1; counter < row.length; counter++) {
    //       print(row[counter]);

    //       if (stringToDoubleTryParse(row[counter]) <= valFromString) {
    //         continue;
    //       } else {
    //         column = counter;
    //         break;
    //       }
    //     }
    //     // retVal = row.firstWhere((element) =>
    //     //     stringToDouble_tryParse(value) >= stringToDouble_tryParse(element));
    //     // row.indexOf(element);

    //   } else {
    //     continue;
    //   }
    // }
    for (var row in lpCsv) {
      if (row[0] == 'indexlength') {
        retVal = row[tableTDRefIndexLP];
        break;
      }
    }
    return retVal;
  }

  Future<String> getCopperSizeHp(String value) async {
    print(value);
    var retVal = '';
    // // double valFromString = stringToDoubleTryParse(value);
    // int column = 0;

    // String slicedVal = value.substring(1, value.length - 1);
    // double valFromString = stringToDoubleTryParse(slicedVal);

    // for (var element in lpRow) {
    //   num elementToDouble = stringToIntTryParse(element);
    //   if (valFromString >= elementToDouble) {
    //     column += 1;

    //     continue;
    //   } else {
    //     break;
    //   }
    // }
    for (var row in hpCsv) {
      if (row[0] == 'indexlength') {
        retVal = row[tableTDRefIndexHP];
        break;
      }
    }
    return retVal;
  }

  String getTDTableRefHp(String value) {
    print("passed in value get td table ref HP " + value);
    var retVal = '';
    String slicedVal = value.substring(1, value.length - 1);
    double valFromString = stringToDoubleTryParse(slicedVal);
    print("passed in value get td table ref HP to num" +
        valFromString.toString());

    print("hpRow" + hpRow.toString());
    for (var element in hpRow) {
      print(element);
      print("element type " + element.runtimeType.toString());
      num elementToDouble = stringToIntTryParse(element);
      print(elementToDouble);
      if (valFromString >= elementToDouble) {
        continue;
      } else {
        retVal = element;
        break;
      }
    }
    tableTDRefIndexHP = hpRow.indexOf(retVal);
    return retVal;
  }

  String getTDTableRefLp(String value) {
    var retVal = 'N/A';
    String slicedVal = value.substring(1, value.length - 1);
    double valFromString = stringToDoubleTryParse(slicedVal);

    for (var element in lpRow) {
      num elementToDouble = stringToIntTryParse(element);
      if (valFromString >= elementToDouble) {
        continue;
      } else {
        retVal = element;
        break;
      }
    }
    tableTDRefIndexLP = lpRow.indexOf(retVal);

    return retVal;
  }

  Future<void> _loadCSV() async {
    hpCsv = _fast_csv.parse(highpressure);
    lpCsv = _fast_csv.parse(lowpressure);
  }

  Future<void> getLpHpLists() async {
    //
    await _loadCSV();
    getIndexLengths();
    print("lp index length " + lpIndexLength.toString());
    print("hp index length " + hpIndexLength.toString());
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

  //TODO:Calculate total demand per lp and hp segment (summation of total demand )
  //Select where keys are the same and reduce/f old list summing up all the total demands from all appliances going through segmenrt

}
