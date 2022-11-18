import 'package:gasworks/constants/route_names.dart';
import 'package:gasworks/models/base_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class HomeViewModel extends BaseViewmodel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  sizingPressed() {
    _navigationService.navigateTo(CreateSitesRoute);
  }

  myDesignsPressed() async {
    await _dialogService.showDialog(
        title: "Page Coming Soon",
        description: "Page Under Construction ... Coming Soon ");
  }

  refInfoPressed() async {
    await _dialogService.showDialog(
        title: "Page Coming Soon",
        description: "Page Under Construction ... Coming Soon ");
  }

  void solarSizingPressed() {
    _navigationService.navigateTo(SolarSizingRoute);
  }
}
