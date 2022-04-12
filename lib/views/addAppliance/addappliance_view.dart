import 'package:flutter/material.dart';
import 'package:gasworks/views/addAppliance/addappliance_view_model.dart';
import 'package:stacked/stacked.dart';

class AddAppliance extends StatelessWidget {
  const AddAppliance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
        viewModelBuilder: () => AddApplianceViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('Page Under Construction'),
            ),
          );
        });
  }
}
