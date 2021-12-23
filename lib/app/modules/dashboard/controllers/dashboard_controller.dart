import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as LocationInstance;
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/models/service_categories_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class DashboardController extends GetxController {
  RxBool isFloatingMenuButtonOpen = false.obs;
  RxDouble topPosition = (-Get.height).obs;
  RxList<ServiceCategories> serviceCategoriesList = <ServiceCategories>[].obs;
  LocationInstance.Location location = LocationInstance.Location();
  final apiHelper = Get.find<ApiHelper>();
  RxString userCurrentLocation = AppStrings.searching.obs;

  @override
  void onInit() {
    super.onInit();
    getServiceCategories();
    getUserLocation();
  }

  @override
  void onReady() {
    super.onReady();
    topPosition.value = 0;
  }

  goToNotifications() {
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  goToSelectedService(int categoryId, String categoryName) {
    Get.toNamed(
      Routes.BOOK_SERVICE,
      arguments: {
        'categoryId': categoryId.toString(),
        'categoryName': categoryName
      },
    );
  }

  void getServiceCategories() {
    apiHelper.getServiceCategories().then(
      (response) {
        if (response.isOk) {
          ServiceCategoriesResponse responseData =
              ServiceCategoriesResponse.fromJson(response.body);
          serviceCategoriesList.value = responseData.data;
        }
      },
    );
  }

  void goToSearch() {
    Get.toNamed(Routes.SEARCH);
  }

  void getUserLocation() async {
    bool serviceEnabled;
    LocationInstance.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == LocationInstance.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != LocationInstance.PermissionStatus.granted) {
        return;
      }
    }

    LocationInstance.LocationData locationData = await location.getLocation();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      locationData.latitude,
      locationData.longitude,
    );
    userCurrentLocation.value = validLocationProvider(placemarks.first);
  }

  String validLocationProvider(Placemark rowLocation) {
    String createdLocation = '';
    if (rowLocation.subLocality != '')
      createdLocation = createdLocation + rowLocation.subLocality + ', ';
    if (rowLocation.locality != '')
      createdLocation = createdLocation + rowLocation.locality + ', ';
    if (rowLocation.administrativeArea != '')
      createdLocation = createdLocation + rowLocation.administrativeArea + ', ';
    if (rowLocation.country != '')
      createdLocation = createdLocation + rowLocation.country;
    return createdLocation;
  }
}
