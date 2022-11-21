import 'package:flutter/material.dart';
import 'package:gasworks/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //TODO:make buttons same size
                  Container(
                    width: width * 0.8,
                    height: height * 0.15,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          model.sizingPressed();
                        },
                        icon: Icon(
                          Icons.straighten,
                          size: 90,
                        ),
                        label: Text(
                          'Sizing',
                          style: TextStyle(fontSize: 30),
                        )),
                  ),
                  Container(
                    width: width * 0.8,
                    height: height * 0.15,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          model.myDesignsPressed();
                        },
                        icon: Icon(
                          Icons.rounded_corner,
                          size: 90,
                        ),
                        label: Text(
                          'My Designs',
                          style: TextStyle(fontSize: 30),
                        )),
                  ),
                  Container(
                    width: width * 0.8,
                    height: height * 0.15,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          model.refInfoPressed();
                        },
                        icon: Icon(
                          Icons.line_weight,
                          size: 90,
                        ),
                        label: Text(
                          'Ref Info',
                          style: TextStyle(fontSize: 30),
                        )),
                  ),
                  Container(
                    width: width * 0.8,
                    height: height * 0.15,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          model.solarSizingPressed();
                        },
                        icon: Icon(
                          Icons.line_weight,
                          size: 90,
                        ),
                        label: Text(
                          'Solar Sizing',
                          style: TextStyle(fontSize: 30),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
