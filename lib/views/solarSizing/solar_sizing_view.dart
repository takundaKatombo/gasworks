import 'package:flutter/material.dart';
import 'package:gasworks/views/solarSizing/solar_sizing_view_model.dart';
import 'package:stacked/stacked.dart';

class SolarSizing extends StatelessWidget {
  const SolarSizing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<SolarSizingViewModel>.reactive(
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
              body: Form(
            key: model.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Load Analysis- Daily Power Required",
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
                      width: width * 0.3,
                      child: Center(
                        child: Text("Daily Consumption(kW)"),
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
                        child: Text("Daily Sun Peak Hours"),
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
                        child: Text("Your Solar Panel Watts"),
                      ),
                    ),
                  ],
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
                      height: height * 0.05,
                      width: width * 0.3,
                      child: Center(
                        child: TextFormField(
                          controller: model.dailyConsumptionController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (model
                                .dailyConsumptionController.text.isNotEmpty) {
                              if (model.isNumericUsingRegularExpression(val!)) {
                                model.dailyConsumption =
                                    model.stringToDouble_tryParse(model
                                        .dailyConsumptionController.text
                                        .trim())!;
                                return null;
                              } else {
                                return 'can only be numeric';

                                // return 'Width can only be a number ';
                              }
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {},
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.05,
                      width: width * 0.3,
                      child: Center(
                        child: TextFormField(
                          controller: model.sunPeakHoursController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (model.sunPeakHoursController.text.isNotEmpty) {
                              if (model.isNumericUsingRegularExpression(val!)) {
                                model.sunPeakHours =
                                    model.stringToDouble_tryParse(model
                                        .sunPeakHoursController.text
                                        .trim())!;
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
                    Container(
                      height: height * 0.05,
                      width: width * 0.3,
                      child: Center(
                        child: TextFormField(
                          controller: model.panelWattsController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (model.panelWattsController.text.isNotEmpty) {
                              if (model.isNumericUsingRegularExpression(val!)) {
                                model.panelWatts =
                                    model.stringToDouble_tryParse(model
                                        .panelWattsController.text
                                        .trim())!;
                                model.calc();
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
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Daily Power (Kilowatts) '),
                        Container(
                          height: height * 0.05,
                          width: width * 0.2,
                          child: Center(
                            child: Text(model.dailyPower.toStringAsFixed(2)),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text('No of Panels required'),
                        Container(
                          height: height * 0.05,
                          width: width * 0.2,
                          child: Center(
                            child: Text(model.numberOfPanels.toString()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  " Sizing the Invertor(Panels In Series)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Panel Values",
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
                      width: width * 0.4,
                      child: Center(
                        child: Text(
                            "Open Circuit Voltage of Panel Voc of Panel (Volts)"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        border: Border.all(),
                      ),
                      height: height * 0.05,
                      width: width * 0.4,
                      child: Center(
                        child: Text(
                            "Short Circuit Current of Panel Isc of Panel (Amps)"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.95,
                padding: EdgeInsets.all(8),
                color: Colors.blue.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.05,
                      width: width * 0.4,
                      child: Center(
                        child: TextFormField(
                          controller: model.panelOpenCircuitVoltageController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (model.panelOpenCircuitVoltageController.text
                                .isNotEmpty) {
                              if (model.isNumericUsingRegularExpression(val!)) {
                                model.panelOpenCircuitVoltage =
                                    model.stringToDouble_tryParse(model
                                        .panelOpenCircuitVoltageController.text
                                        .trim())!;
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
                      height: height * 0.05,
                      width: width * 0.4,
                      child: Center(
                        child: TextFormField(
                          controller: model.panelShortCircuitCurrentController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (model.panelShortCircuitCurrentController.text
                                .isNotEmpty) {
                              if (model.isNumericUsingRegularExpression(val!)) {
                                model.panelShortCircuitCurrent =
                                    model.stringToDouble_tryParse(model
                                        .panelShortCircuitCurrentController.text
                                        .trim())!;
                                model.calcMaxPV();
                                model.calcminVdc();
                                return null;
                              } else {
                                return 'can only be numeric';
                                // return 'Height can only be a number ';
                              }
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Your Inverter Values",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: width,
                padding: EdgeInsets.all(7),
                color: Colors.blue.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            border: Border.all(),
                          ),
                          height: height * 0.05,
                          width: width * 0.32,
                          child: Center(
                            child: Text(
                                "Max PV Array Power of your invertor (Wp)"),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            border: Border.all(),
                          ),
                          height: height * 0.05,
                          width: width * 0.32,
                          child: Center(
                            child: Text("Max Dc Input of your invertor (Vdc)"),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            border: Border.all(),
                          ),
                          height: height * 0.05,
                          width: width * 0.4,
                          child: Center(
                            child: Text(
                                "Max PV Charging  input Current of your invertor (A)"),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: height * 0.05,
                          width: width * 0.55,
                          child: Center(
                            child: TextFormField(
                              // decoration: const InputDecoration(
                              //     errorMaxLines: 3,
                              //     errorStyle: TextStyle(fontSize: 10)),
                              controller: model.wpController,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (model.wpController.text.isNotEmpty) {
                                  if (model
                                      .isNumericUsingRegularExpression(val!)) {
                                    if (model.stringToDouble_tryParse(val)! <
                                        model.maxPVPowerWatts) {
                                      return 'cannot be less than ${model.maxPVPowerWatts}';
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return 'can only be numeric';
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          height: height * 0.05,
                          width: width * 0.4,
                          child: Center(
                            child: TextFormField(
                              controller: model.vdcController,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (model.vdcController.text.isNotEmpty) {
                                  if (model
                                      .isNumericUsingRegularExpression(val!)) {
                                    if (model.stringToDouble_tryParse(val)! <
                                        model.minVdc) {
                                      return 'cannot be less than ${model.minVdc}';
                                    } else {
                                      return null;
                                    }
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
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          height: height * 0.05,
                          width: width * 0.4,
                          child: Center(
                            child: TextFormField(
                              controller: model.chargingInputCurrentController,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (model.chargingInputCurrentController.text
                                    .isNotEmpty) {
                                  if (model
                                      .isNumericUsingRegularExpression(val!)) {
                                    if (model.stringToDouble_tryParse(val)! <
                                        model.panelShortCircuitCurrent) {
                                      return 'cannot be less than ${model.panelShortCircuitCurrent}';
                                    } else {
                                      return null;
                                    }
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
                  ],
                ),
              ),
            ]),
          )),
        );
      },
      viewModelBuilder: () => SolarSizingViewModel(),
    );
  }
}
