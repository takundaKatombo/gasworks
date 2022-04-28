import 'package:flutter/material.dart';
import 'package:gasworks/views/addAppliance/addappliance_view_model.dart';
import 'package:stacked/stacked.dart';

class AddAppliance extends StatelessWidget {
  const AddAppliance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("NA"), value: "NA"),
      DropdownMenuItem(child: Text("Kitchen"), value: "Kitchen"),
      DropdownMenuItem(child: Text("Dining"), value: "Dining"),
      DropdownMenuItem(child: Text("Lounge"), value: "Lounge"),
    ];

    return ViewModelBuilder<AddApplianceViewModel>.reactive(
        viewModelBuilder: () => AddApplianceViewModel(),
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              body: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Adding Appliance",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            model.showRules();
                          },
                          child: Text(
                            "Press here to see whats not allowed",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: model.formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: height * 0.08,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: TextFormField(
                                  controller: model.applianceNameController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Appliance Name'),
                                  validator: (val) {
                                    if (model
                                        .applianceNameController.text.isEmpty) {
                                      return 'cannot be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.08,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: TextFormField(
                                  controller: model.teesController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'tees in this line'),
                                  validator: (val) {
                                    if (model.isNumericUsingRegularExpression(
                                        val!)) {
                                      return null;
                                    } else {
                                      return 'can only be numeric';

                                      // return 'Length can only be a number';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.08,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: TextFormField(
                                controller: model.elbowsController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration.collapsed(
                                    hintText: 'elbows in this line'),
                                validator: (val) {
                                  if (model
                                      .isNumericUsingRegularExpression(val!)) {
                                    return null;
                                  } else {
                                    return 'can only be numeric';

                                    // return 'Width can only be a number ';
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.08,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: TextFormField(
                                controller: model.bendsController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration.collapsed(
                                    hintText: 'bends in this line'),
                                validator: (val) {
                                  if (model
                                      .isNumericUsingRegularExpression(val!)) {
                                    return null;
                                  } else {
                                    return 'can only be numeric';
                                    // return 'Height can only be a number ';
                                  }
                                },
                                // onFieldSubmitted: (val) {
                                //   // if (model.formKey.currentState!.validate()) {
                                //   //   model.checkAddRoom();
                                //   // } else {
                                //   //   model.showFailedValidation();
                                //   // }
                                // },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Total Demand"),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Container(
                              height: height * 0.07,
                              width: width * 0.2,
                              // decoration: BoxDecoration(
                              //     border: Border.all(),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: TextFormField(
                                  controller: model.totalDemandController,
                                  keyboardType: TextInputType.number,
                                  // decoration: new InputDecoration.collapsed(
                                  //     hintText: 'elbows in this line'),
                                  validator: (val) {
                                    if (model.isNumericUsingRegularExpression(
                                        val!)) {
                                      return null;
                                    } else {
                                      return 'can only be numeric';

                                      // return 'Width can only be a number ';
                                    }
                                  },
                                ),
                              ),
                            ),
                            Radio(
                                value: "kg",
                                groupValue: model.tdUnit,
                                onChanged: (String? val) {
                                  model.tdUnitSet(val!);
                                }),
                            Text("kg/h"),
                            Radio(
                                value: 'mu',
                                groupValue: model.tdUnit,
                                onChanged: (String? val) {
                                  model.tdUnitSet(val!);
                                }),
                            Text("MU/h"),
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        height: height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Which room is Appliance in ?"),
                            DropdownButton(
                              items: model.roomsList.roomsList
                                  .map((description, value) {
                                    return MapEntry(
                                        description,
                                        DropdownMenuItem<String>(
                                          value: description,
                                          child: Text(description),
                                        ));
                                  })
                                  .values
                                  .toList(),
                              value: model.roomName,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  model.roomName = newValue;
                                }
                              },
                              // validator: (value) =>
                              //     value == null ? "Select a room" : null,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Is Device Flued"),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Radio(
                                value: true,
                                groupValue: model.deviceFlued,
                                onChanged: (bool? val) {
                                  model.deviceFluedSet(val!);
                                }),
                            Text("Yes"),
                            Radio(
                                value: false,
                                groupValue: model.deviceFlued,
                                onChanged: (bool? val) {
                                  model.deviceFluedSet(val!);
                                }),
                            Text("No"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: height * 0.06,
                              width: width * 0.4,
                              child: Center(
                                  child: Text(
                                "Add Segments",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ))),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: height * 0.08,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: TextFormField(
                                  controller: model.segmentLabelController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Segmanet Label'),
                                  validator: (val) {
                                    if (model
                                        .segmentLabelController.text.isEmpty) {
                                      return 'can not be empty';
                                    } else if (model.segmentLabelController.text
                                            .length !=
                                        2) {
                                      return 'can only be 2 chars';
                                    } else {
                                      model.segmentLabelController.text
                                          .toUpperCase();
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.08,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: TextFormField(
                                  // controller: model.lengthController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Meters'),
                                  validator: (val) {
                                    if (model.isNumericUsingRegularExpression(
                                        val!)) {
                                      return null;
                                    } else {
                                      return 'can only be numeric';

                                      // return 'Length can only be a number';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ]),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Line Part of HP or LP run"),
                            Radio(
                                value: 'hp',
                                groupValue: model.lineHpLp,
                                onChanged: (String? val) {
                                  model.lineHpLpSet(val!);
                                }),
                            Text("HP"),
                            Radio(
                                value: 'lp',
                                groupValue: model.lineHpLp,
                                onChanged: (String? val) {
                                  model.lineHpLpSet(val!);
                                }),
                            Text("LP"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  model.onAddSegmentPressed();
                                },
                                child: Text('Add Segment'))
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Segments List",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
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
                              width: width * 0.3,
                              child: Center(
                                child: Text("Segment Label"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                border: Border.all(),
                              ),
                              height: height * 0.05,
                              width: width * 0.3,
                              child: Center(
                                child: Text("Metres"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                border: Border.all(),
                              ),
                              height: height * 0.05,
                              width: width * 0.3,
                              child: Center(
                                child: Text("Remove"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.25,
                        child: ListView.builder(
                            itemCount: model.segments.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = model.segments.keys.elementAt(index);
                              double area =
                                  model.segments.values.elementAt(index);
                              return Container(
                                height: 50,
                                // width: width * 0.95,
                                // margin: EdgeInsets.all(2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      height: height * 0.06,
                                      width: width * 0.3,
                                      child: Center(child: Text(key)),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      height: height * 0.06,
                                      width: width * 0.3,
                                      child:
                                          Center(child: Text(area.toString())),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      height: height * 0.06,
                                      width: width * 0.3,
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              model.removeSegment(key);
                                            },
                                            child: Text('Delete')),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width * 0.4,
                            child: Text(
                              "Appliance Name ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Container(
                            width: width * 0.4,
                            child: Text(
                              "Total Length(Including Fittings)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: height * 0.25,
                        child: ListView.builder(
                            itemCount: model.appliances.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key =
                                  model.appliances.keys.elementAt(index);
                              double area =
                                  model.appliances.values.elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.blue.shade100,
                                  height: 50,
                                  // width: width * 0.95,
                                  // margin: EdgeInsets.all(2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: width * 0.4,
                                        child: Text(
                                          key,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.4,
                                        child: Text(
                                          "15",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                              ; //todo:Pass map key as key for item deletion
                            }),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: Text('Save and Add Another ')),
                            ElevatedButton(
                                onPressed: () {},
                                child: Text('Save and Continue'))
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
