import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasworks/views/addAppliance/addappliance_view_model.dart';
import 'package:stacked/stacked.dart';

class AddAppliance extends StatelessWidget {
  const AddAppliance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
   

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
                            Text('Appliance Name'),
                            Container(
                              height: height * 0.08,
                              width: width * 0.3,
                              child: Center(
                                child: TextFormField(
                                  controller: model.applianceNameController,
                                  validator: (val) {
                                    if (model
                                        .applianceNameController.text.isEmpty) {
                                      return 'cannot be empty';
                                    } else if (model.appliances.containsKey(
                                        model.applianceNameController.text)) {
                                      return 'cannot have duplicate values ';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Text('tees'),
                            Container(
                              height: height * 0.08,
                              width: width * 0.3,
                              // decoration: BoxDecoration(
                              //     border: Border.all(),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: TextFormField(
                                  controller: model.teesController,
                                  keyboardType: TextInputType.number,
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
                          Text('Elbows'),
                          Container(
                            height: height * 0.08,
                            width: width * 0.2,
                            child: Center(
                              child: TextFormField(
                                controller: model.elbowsController,
                                keyboardType: TextInputType.number,
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
                          Text('Bends'),
                          Container(
                            height: height * 0.08,
                            width: width * 0.2,
                            child: Center(
                              child: TextFormField(
                                controller: model.bendsController,
                                keyboardType: TextInputType.number,

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
                                value: 'true',
                                groupValue: model.deviceFlued,
                                onChanged: (String? val) {
                                  model.deviceFluedSet(val!);
                                }),
                            Text("Yes"),
                            Radio(
                                value: 'false',
                                groupValue: model.deviceFlued,
                                onChanged: (String? val) {
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
                            Text('Segment Label'),
                            Container(
                              height: height * 0.08,
                              width: width * 0.3,
                              child: Center(
                                child: TextFormField(
                                  inputFormatters: [UpperCaseTextFormatter()],
                                  controller: model.segmentLabelController,
                                  validator: (val) {
                                    if (model
                                        .segmentLabelController.text.isEmpty) {
                                      return 'can not be empty';
                                    } else if (model.segmentLabelController.text
                                            .length !=
                                        2) {
                                      return 'can only be 2 chars';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Text('Meters'),
                            Container(
                              height: height * 0.08,
                              width: width * 0.2,
                              child: Center(
                                child: TextFormField(
                                  controller: model.lengthController,
                                  keyboardType: TextInputType.number,
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
                                  if (model.formKey.currentState!.validate() &&
                                      model.lineHpLp.isNotEmpty &&
                                      model.deviceFlued.isNotEmpty &&
                                      model.lineHpLp.isNotEmpty) {
                                    model.onAddSegmentPressed();
                                    model.clearFields();
                                  } else {
                                    model.showValidationFailed();
                                  }
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
                              String area = model.segments.values
                                  .elementAt(index)
                                  .toString();
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  model.saveApplianceAndAdd();
                                },
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
