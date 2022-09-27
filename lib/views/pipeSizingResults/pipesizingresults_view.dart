import 'package:flutter/material.dart';
import 'package:gasworks/views/pipeSizingResults/pipesizingresults_view_model.dart';
import 'package:stacked/stacked.dart';

class PipeSizingResults extends StatelessWidget {
  const PipeSizingResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<PipeSizingResultsViewModel>.reactive(
        viewModelBuilder: () => PipeSizingResultsViewModel(),
        onModelReady: (viewModel) async => await viewModel.getLpHpLists(),
        builder: (context, model, child) {
          // print('running get lists ');
          // model.getLpHpLists;
          // print(model.hp.length);
          // print(model.lp.length);
          return Scaffold(
            body: ListView(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "HP - High Pressure Table",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Per Segments Workings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                  width: width * 0.95,
                  padding: EdgeInsets.all(4),
                  color: Colors.blue.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          border: Border.all(),
                        ),
                        height: height * 0.05,
                        width: width * 0.2,
                        child: Center(
                          child: Text("Segments "),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          border: Border.all(),
                        ),
                        height: height * 0.05,
                        width: width * 0.2,
                        child: Center(
                          child: Text("TD(MUH) All Appliances Per Segment"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          border: Border.all(),
                        ),
                        height: height * 0.05,
                        width: width * 0.2,
                        child: Center(
                          child: Text("Table X-Ref MU/h"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          border: Border.all(),
                        ),
                        height: height * 0.05,
                        width: width * 0.2,
                        child: Center(
                          child: Text("Copper Size "),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.25,
                  child: ListView.builder(
                      itemCount: model.hp.length,
                      itemBuilder: (BuildContext context, int index) {
                        //
                        return Container(
                          height: 50,
                          // width: width * 0.95,
                          // margin: EdgeInsets.all(2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                height: height * 0.06,
                                width: width * 0.2,
                                child: Center(
                                    child:
                                        Text(model.hp[index].keys.toString())),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                height: height * 0.06,
                                width: width * 0.2,
                                child: Center(
                                    child: Text(
                                        model.hp[index].values.toString())),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                height: height * 0.06,
                                width: width * 0.2,
                                child: Center(
                                  child: Text(''),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                height: height * 0.06,
                                width: width * 0.2,
                                child: Center(
                                  child: Text(''),
                                ),
                              ),
                            ],
                          ),
                        ); //todo:Pass map key as key for item deletion
                      }),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "LP - Low Pressure Table",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Per Segments Workings",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Container(
                  width: width * 0.95,
                  padding: EdgeInsets.all(4),
                  color: Colors.blue.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          border: Border.all(),
                        ),
                        height: height * 0.05,
                        width: width * 0.2,
                        child: Center(
                          child: Text("Segments "),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          border: Border.all(),
                        ),
                        height: height * 0.05,
                        width: width * 0.2,
                        child: Center(
                          child: Text("TD(MUH) All Appliances Per Segment"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          border: Border.all(),
                        ),
                        height: height * 0.05,
                        width: width * 0.2,
                        child: Center(
                          child: Text("Table X-Ref MU/h"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          border: Border.all(),
                        ),
                        height: height * 0.05,
                        width: width * 0.2,
                        child: Center(
                          child: Text("Copper Size "),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.25,
                  child: ListView.builder(
                      itemCount: model.reducedLP.length,
                      itemBuilder: (BuildContext context, int index) {
                        //
                        return Container(
                          height: 50,
                          // width: width * 0.95,
                          // margin: EdgeInsets.all(2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                height: height * 0.06,
                                width: width * 0.2,
                                child: Center(
                                    child:
                                        Text(model.lp[index].keys.toString())),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                height: height * 0.06,
                                width: width * 0.2,
                                child: Center(
                                    child: Text(
                                        model.lp[index].values.toString())),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                height: height * 0.06,
                                width: width * 0.2,
                                child: Center(
                                  child: Text(
                                      "model.getTDTableRefLp(model.lp[index].values.toString())"),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                height: height * 0.06,
                                width: width * 0.2,
                                child: Center(
                                  child: Text('model.hpCsv[0][1].toString()'),
                                ),
                              ),
                            ],
                          ),
                        ); //todo:Pass map key as key for item deletion
                      }),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
              ],
            ),
          );
        });
  }
}
