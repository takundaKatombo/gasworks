import 'package:flutter/material.dart';
import 'package:gasworks/views/createsite/createsite_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<CreateSiteViewModel>.reactive(
      builder: (context, model, child) {
        final siteNameController = TextEditingController();
        final customerNameController = TextEditingController();
        final customerCellController = TextEditingController();
        final addressController = TextEditingController();
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Form(
                key: model.formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " Login ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      height: height * 0.06,
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: TextFormField(
                          controller: siteNameController,
                          decoration: new InputDecoration.collapsed(
                              hintText: 'username'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      height: height * 0.06,
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: TextFormField(
                          controller: customerNameController,
                          decoration: new InputDecoration.collapsed(
                              hintText: 'Password'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("Login "))
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => CreateSiteViewModel(),
    );
  }
}
