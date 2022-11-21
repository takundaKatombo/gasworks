import 'package:flutter/material.dart';
import 'package:gasworks/views/addrooms/addrooms_view_model.dart';
// import 'package:gasworks/views/shared/roomsListWidget.dart';
import 'package:stacked/stacked.dart';

class AddRooms extends StatelessWidget {
  const AddRooms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ViewModelBuilder<AddRoomsViewModel>.reactive(
        viewModelBuilder: () => AddRoomsViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: ListView(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Adding Rooms",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    color: Colors.blue.shade100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Don't Want to add Rooms "),
                        Checkbox(
                          // tristate: true,
                          value: model.noRoom,
                          onChanged: (val) {
                            model.noRooms(val!);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
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
                                  controller: model.roomNameController,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Room Name'),
                                  validator: (val) {
                                    if (model
                                        .roomNameController.text.isNotEmpty) {
                                      model.roomName = val;
                                      return null;
                                    } else {
                                      return 'cannot be empty';
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
                                  controller: model.lengthController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: 'Length'),
                                  validator: (val) {
                                    if (model
                                        .lengthController.text.isNotEmpty) {
                                      if (model.isNumericUsingRegularExpression(
                                          val!)) {
                                        model.length =
                                            model.stringToDouble_tryParse(val)!;
                                        return null;
                                      } else {
                                        return 'can only be numeric';

                                        // return 'Length can only be a number';
                                      }
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: height * 0.03,
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
                                controller: model.widthController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration.collapsed(
                                    hintText: 'Width'),
                                validator: (val) {
                                  if (model.widthController.text.isNotEmpty) {
                                    if (model.isNumericUsingRegularExpression(
                                        val!)) {
                                      model.width =
                                          model.stringToDouble_tryParse(val)!;
                                      return null;
                                    } else {
                                      return 'can only be numeric';

                                      // return 'Width can only be a number ';
                                    }
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
                                controller: model.heightController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration.collapsed(
                                    hintText: 'Height'),
                                validator: (val) {
                                  if (model.heightController.text.isNotEmpty) {
                                    if (model.isNumericUsingRegularExpression(
                                        val!)) {
                                      model.height =
                                          model.stringToDouble_tryParse(val)!;
                                      model.checkAddRoom();
                                      return null;
                                    } else {
                                      return 'can only be numeric';
                                      // return 'Height can only be a number ';
                                    }
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ]),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (model.formKey.currentState!.validate()) {
                              model.addToRoomList();
                            } else {
                              model.showFailedValidation();
                            }
                          },
                          child: Text('Add Room'))
                    ],
                  ),
                  //TODO:ADD DYNAMIC SLIVER LIST TO ADD ROOMS WHICH SHOULD BE COllAPSIBLE
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Rooms List",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                            child: Text("Room Name"),
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
                            child: Text("Square Metres"),
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
                        itemCount: model.roomsList.roomsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          String key = '';
                          double area = 0.0;
                          if (model.roomsList.roomsList.keys.elementAt(index) !=
                              'N/A') {
                            key =
                                model.roomsList.roomsList.keys.elementAt(index);
                            area = model.roomsList.roomsList.values
                                .elementAt(index);
                          }

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
                                  child: Center(child: Text(area.toString())),
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
                                          model.removeRoom(key);
                                        },
                                        child: Text('Delete')),
                                  ),
                                ),
                              ],
                            ),
                          ); //todo:Pass map key as key for item deletion
                        }),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed:
                            model.noRoom || model.roomsList.roomsList.isNotEmpty
                                ? () {
                                    model.saveContinuePressed();
                                    model.addNA();
                                  }
                                : null,
                        child: Text("Save and Continue"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
