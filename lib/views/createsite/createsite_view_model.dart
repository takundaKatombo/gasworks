import 'package:flutter/material.dart';
import 'package:gasworks/constants/route_names.dart';
import 'package:gasworks/models/base_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class CreateSiteViewModel extends BaseViewmodel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final GlobalKey<FormState> formKey = GlobalKey();

  void nextPressed() {
    _navigationService.navigateTo(AddRoomsRoute);
  }

  Future<void> siteNameEmpty() async {
    await _dialogService.showDialog(
        title: "Site Name Empty", description: "Please Fill in Site Name ");
  }
}
