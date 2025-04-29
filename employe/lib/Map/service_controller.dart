
import 'package:employe/untils/exports.dart';
import 'package:geolocator/geolocator.dart';

class ServiceController extends GetxController {
  var longitude = -122.085749655962;
  var latittude = 37.42796133580664;


  var address = "".obs;
  var addressLatitude = "".obs;
  var addressLongitude = "".obs;
  var loacationIsEnabled = false.obs;

  Position? position;
  String celebrateText = "";
  String profileImageData = "";
  var eachStoryList = {}.obs;
  var isLoading = false.obs;
 


  
}
