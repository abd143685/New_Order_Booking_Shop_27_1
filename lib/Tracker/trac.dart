import 'dart:async';
import 'dart:io';
import 'dart:isolate';
//import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gpx/gpx.dart';
import 'package:intl/intl.dart';
import 'package:order_booking_shop/API/ApiServices.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/Globals.dart';
import '../Views/HomePage.dart';
import 'package:location/location.dart' as loc;
//import 'package:carp_background_location/carp_background_location.dart';

import '../main.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

var gpx;
var track;
var segment;
var trkpt;
var longi;
var lat;

String gpxString="";
//StreamSubscription<Position>? _positionStreamSubscription;


// StreamSubscription<Position>? positionStream;
// Future<void> listenLocation() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   userIdForLocation = pref.getString("userNames") ?? "USER";
//   try {
//     await Firebase.initializeApp();
//     gpx = new Gpx();
//     track = new Trk();
//     segment = new Trkseg();
//     print("W100 Start");
//     final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
//
//     final downloadDirectory = await getDownloadsDirectory();
//     final filePath = "${downloadDirectory!.path}/track$date.gpx";
//
//     File file = new File(filePath);
//     bool isFirstRun = !file.existsSync();
//
//     if (isFirstRun) {
//       file.createSync();
//     } else {
//       Gpx existingGpx = GpxReader().fromString(file.readAsStringSync());
//       gpx.trks.add(existingGpx.trks[0]);
//       track = gpx.trks[0];
//       segment = new Trkseg();
//       track.trksegs.add(segment);
//     }
//
//     late LocationSettings locationSettings;
//     locationSettings = AndroidSettings(
//       accuracy: LocationAccuracy.bestForNavigation,
//       distanceFilter: 100,
//       forceLocationManager: true,
//       intervalDuration: const Duration(seconds: 3),
//     );
//
//     positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) async {
//       print("W100 Repeat");
//       await FirebaseFirestore.instance.collection('location').doc(userIdForLocation.toString()).set({
//         'latitude': position.latitude,
//         'longitude': position.longitude,
//         'name': userIdForLocation.toString(),
//         'isActive': true
//       }, SetOptions(merge: true));
//       longi = position.longitude.toString();
//       lat = position.latitude.toString();
//       final trackPoint = Wpt(
//         lat: position.latitude,
//         lon: position.longitude,
//         time: DateTime.now(),
//       );
//
//       segment.trkpts.add(trackPoint);
//
//       if (isFirstRun) {
//         track.trksegs.add(segment);
//         gpx.trks.add(track);
//         isFirstRun = false;
//       }
//
//       gpxString = GpxWriter().asString(gpx, pretty: true);
//       print("W100 $gpxString");
//
//       file.writeAsStringSync(gpxString);
//     });
//     print("W100 END");
//   } catch (e) {
//     print('W100 An error occurred: $e');
//   }
// }


// StreamSubscription<loc.LocationData>? _locationSubscription;
//
// Future<void> listenLocation() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   userIdForLocation = pref.getString("userNames") ?? "USER";
//   try {
//     await Firebase.initializeApp();
//     gpx = new Gpx();
//     track = new Trk();
//     segment = new Trkseg();
//     print("W100 Start");
//     final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
//
//     final downloadDirectory = await getDownloadsDirectory();
//     final filePath = "${downloadDirectory!.path}/track$date.gpx";
//
//     File file = new File(filePath);
//     bool isFirstRun = !file.existsSync();
//
//     if (isFirstRun) {
//       file.createSync();
//     } else {
//       Gpx existingGpx = GpxReader().fromString(file.readAsStringSync());
//       gpx.trks.add(existingGpx.trks[0]);
//       track = gpx.trks[0];
//       segment = new Trkseg();
//       track.trksegs.add(segment);
//     }
//
//     loc.Location location = new loc.Location();
//
//     _locationSubscription = location.onLocationChanged.listen((loc.LocationData currentLocation) async {
//       print("W100 Repeat");
//       await FirebaseFirestore.instance.collection('location').doc(userIdForLocation.toString()).set({
//         'latitude': currentLocation.latitude,
//         'longitude': currentLocation.longitude,
//         'name': userIdForLocation.toString(),
//         'isActive': true
//       }, SetOptions(merge: true));
//       long = currentLocation.longitude.toString();
//       lat = currentLocation.latitude.toString();
//       final trackPoint = Wpt(
//         lat: currentLocation.latitude,
//         lon: currentLocation.longitude,
//         time: DateTime.now(),
//       );
//
//       segment.trkpts.add(trackPoint);
//
//       if (isFirstRun) {
//         track.trksegs.add(segment);
//         gpx.trks.add(track);
//         isFirstRun = false;
//       }
//
//       gpxString = GpxWriter().asString(gpx, pretty: true);
//       print("W100 $gpxString");
//
//       file.writeAsStringSync(gpxString);
//     });
//     print("W100 END");
//   } catch (e) {
//     print('W100 An error occurred: $e');
//   }
// }

// Future<void> listenLocation() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   userIdForLocation = pref.getString("userNames") ?? "USER";
//   try {
//     await Firebase.initializeApp();
//     gpx = new Gpx();
//     track = new Trk();
//     segment = new Trkseg();
//     print("W100 Start");
//     final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
//
//     final downloadDirectory = await getDownloadsDirectory();
//     final filePath = "${downloadDirectory!.path}/track$date.gpx";
//
//     File file = new File(filePath);
//     bool isFirstRun = !file.existsSync();
//
//     if (isFirstRun) {
//       file.createSync();
//     } else {
//       Gpx existingGpx = GpxReader().fromString(file.readAsStringSync());
//       gpx.trks.add(existingGpx.trks[0]);
//       track = gpx.trks[0];
//       segment = new Trkseg();
//       track.trksegs.add(segment);
//     }
//
//     Timer.periodic(Duration(seconds: 1), (Timer t) async {
//       print("W100 Repeat");
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
//       await FirebaseFirestore.instance.collection('location').doc(userIdForLocation.toString()).set({
//         'latitude': position.latitude,
//         'longitude': position.longitude,
//         'name': userIdForLocation.toString(),
//         'isActive': true
//       }, SetOptions(merge: true));
//       long = position.longitude.toString();
//       lat = position.latitude.toString();
//       final trackPoint = Wpt(
//         lat: position.latitude,
//         lon: position.longitude,
//         time: DateTime.now(),
//       );
//
//       segment.trkpts.add(trackPoint);
//
//       if (isFirstRun) {
//         track.trksegs.add(segment);
//         gpx.trks.add(track);
//         isFirstRun = false;
//       }
//
//       gpxString = GpxWriter().asString(gpx, pretty: true);
//       print("W100 $gpxString");
//
//       file.writeAsStringSync(gpxString);
//     });
//   } catch (e) {
//     print('W100 An error occurred: $e');
//   }
// }

// getLocation() async {
//   try {
//     final Position position = await Geolocator.getCurrentPosition();
//     await FirebaseFirestore.instance.collection('location').doc(userIdForLocation).set({
//       'latitude': position.latitude,
//       'longitude': position.longitude,
//       'name': name.toString(),
//       'isActive': false
//     }, SetOptions(merge: true));
//   } catch (e) {
//     print(e);
//   }
// }

Future<void> startTimer() async {
  startTimerFromSavedTime();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Timer.periodic(Duration(seconds: 1), (timer) async {
    secondsPassed++;
    await prefs.setInt('secondsPassed', secondsPassed);
  });
}

void startTimerFromSavedTime() {
  SharedPreferences.getInstance().then((prefs) async {
    String savedTime = prefs.getString('savedTime') ?? '00:00:00';
    List<String> timeComponents = savedTime.split(':');
    int hours = int.parse(timeComponents[0]);
    int minutes = int.parse(timeComponents[1]);
    int seconds = int.parse(timeComponents[2]);
    int totalSavedSeconds = hours * 3600 + minutes * 60 + seconds;
    final now = DateTime.now();
    int totalCurrentSeconds = now.hour * 3600 + now.minute * 60 + now.second;
    secondsPassed = totalCurrentSeconds - totalSavedSeconds;
    if (secondsPassed < 0) {
      secondsPassed = 0;
    }
    await prefs.setInt('secondsPassed', secondsPassed);
    print("Loaded Saved Time");
  });
}


// class LocationService {
//   //late LocationManager locationManager;
//   late Gpx gpx;
//   late Trk track;
//   late Trkseg segment;
//   late File file;
//   late bool isFirstRun;
//   late bool isConnected;
//   //late StreamSubscription<LocationDto> locationSubscription;
//   late String userIdForLocation;
//   late final filepath;
//   late final Directory? downloadDirectory;
//   late double totalDistance;
//   late Position? lastTrackPoint;
//   Isolate? locationIsolate;
//
//   LocationService() {
//     totalDistance = 0.0;
//     lastTrackPoint = null;
//     init();
//     Firebase.initializeApp();
//
//   }
//
//   StreamSubscription<Position>? positionStream;
//   Future<void> listenLocation() async {
//
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     userIdForLocation = pref.getString("userNames") ?? "USER";
//     try {
//       gpx = new Gpx();
//       track = new Trk();
//       segment = new Trkseg();
//       print("W100 Start");
//       final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
//
//       final downloadDirectory = await getDownloadsDirectory();
//       final filePath = "${downloadDirectory!.path}/track$date.gpx";
//
//       File file = new File(filePath);
//       bool isFirstRun = !file.existsSync();
//
//       if (isFirstRun) {
//         file.createSync();
//       } else {
//         Gpx existingGpx = GpxReader().fromString(file.readAsStringSync());
//         gpx.trks.add(existingGpx.trks[0]);
//         track = gpx.trks[0];
//         segment = new Trkseg();
//         track.trksegs.add(segment);
//       }
//
//       late LocationSettings locationSettings;
//       locationSettings = AndroidSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 10,
//         forceLocationManager: true,
//         intervalDuration: const Duration(seconds: 1),
//       );
//
//
//
//       positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) async {
//         print("W100 Repeat");
//         isConnected = await isInternetConnected();
//         if(isConnected){
//           await FirebaseFirestore.instance.collection('location').doc(userIdForLocation.toString()).set({
//             'latitude': position.latitude,
//             'longitude': position.longitude,
//             'name': userIdForLocation.toString(),
//             'isActive': true
//           }, SetOptions(merge: true));
//         }
//
//         longi = position.longitude.toString();
//         lat = position.latitude.toString();
//         final trackPoint = Wpt(
//           lat: position.latitude,
//           lon: position.longitude,
//           time: DateTime.now(),
//         );
//
//         segment.trkpts.add(trackPoint);
//
//         if (isFirstRun) {
//           track.trksegs.add(segment);
//           gpx.trks.add(track);
//           isFirstRun = false;
//         }
//
//         if (lastTrackPoint != null) {
//           totalDistance += calculateDistance(
//             lastTrackPoint!.latitude,
//             lastTrackPoint!.longitude,
//             position.latitude,
//             position.longitude,
//           );
//         }
//
//         lastTrackPoint = Position(
//           latitude: position.latitude,
//           longitude: position.longitude,
//           accuracy: 0,
//           altitude: 0,
//           altitudeAccuracy: 0,
//           heading: 0,
//           headingAccuracy: 0,
//           speed: 0,
//           speedAccuracy: 0,
//           timestamp: DateTime.now(),
//         );
//
//
//         gpxString = GpxWriter().asString(gpx, pretty: true);
//         print("W100 $gpxString");
//
//         file.writeAsStringSync(gpxString);
//       });
//       print("W100 END");
//     } catch (e) {
//       print('W100 An error occurred: $e');
//     }
//   }
//
//   Future<void> requestPermissions() async {
//     final notificationStatus = await Permission.notification.status;
//     final locationStatus = await Permission.location.status;
//
//     if (!notificationStatus.isGranted) {
//       PermissionStatus newNotificationStatus = await Permission.notification.request();
//
//       if (newNotificationStatus.isGranted) {
//         print('Notification permission granted');
//       } else if (newNotificationStatus.isDenied) {
//         print('Notification permission denied');
//       } else if (newNotificationStatus.isPermanentlyDenied) {
//         openAppSettings();
//       }
//     } else {
//       print('Notification permission already granted');
//     }
//
//     if (!locationStatus.isGranted) {
//       PermissionStatus newLocationStatus = await Permission.location.request();
//
//       if (newLocationStatus.isGranted) {
//         print('Location permission granted');
//       } else if (newLocationStatus.isDenied) {
//         print('Location permission denied');
//       } else if (newLocationStatus.isPermanentlyDenied) {
//         openAppSettings();
//       }
//     } else {
//       print('Location permission already granted');
//     }
//   }
//
//
//   Future<void> init() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     userIdForLocation = pref.getString("userNames") ?? "USER";
//   }
//
//   // Future<void> listenLocation() async {
//   //   downloadDirectory = await getDownloadsDirectory();
//   //   filepath = "${downloadDirectory?.path}/track${DateFormat('dd-MM-yyyy').format(DateTime.now())}.gpx";
//   //   gpx = new Gpx();
//   //   track = new Trk();
//   //   segment = new Trkseg();
//   //   file = File(filepath);
//   //   isFirstRun = !file.existsSync();
//   //   isConnected = await isInternetConnected();
//   //   try {
//   //     //WakelockPlus.enabled;
//   //     AndroidSettings settings = const AndroidSettings(
//   //       accuracy: LocationAccuracy.NAVIGATION,
//   //       interval: 1,
//   //       distanceFilter: 2,
//   //     );
//   //
//   //     if (file != null) {
//   //       if (isFirstRun) {
//   //         file?.createSync();
//   //       } else {
//   //         Gpx existingGpx = GpxReader().fromString(file!.readAsStringSync());
//   //         if (existingGpx.trks.isNotEmpty) {
//   //           track = existingGpx.trks[0];
//   //           segment = new Trkseg();
//   //           track.trksegs.add(segment);
//   //         } else {
//   //           track = new Trk();
//   //           segment = new Trkseg();
//   //           track.trksegs.add(segment);
//   //         }
//   //         gpx.trks.add(track);
//   //       }
//   //     }
//   //
//   //     LocationManager().interval = settings.interval;
//   //     LocationManager().distanceFilter = settings.distanceFilter;
//   //     LocationManager().accuracy = settings.accuracy;
//   //     LocationManager().notificationTitle = 'Running Location Service';
//   //
//   //     await LocationManager().start();
//   //     locationSubscription =
//   //         LocationManager().locationStream.listen((LocationDto position) async {
//   //           isConnected = await isInternetConnected();
//   //           if (isConnected) {
//   //             await FirebaseFirestore.instance
//   //                 .collection('location')
//   //                 .doc(userIdForLocation.toString())
//   //                 .set({
//   //               'latitude': position.latitude,
//   //               'longitude': position.longitude,
//   //               'name': userIdForLocation.toString(),
//   //               'isActive': true
//   //             }, SetOptions(merge: true));
//   //           }
//   //           print("w100 'Longitute ${position.latitude} Latitute ${position.longitude}'");
//   //           final trackPoint = Wpt(
//   //             lat: position.latitude,
//   //             lon: position.longitude,
//   //             time: DateTime.now(),
//   //           );
//   //
//   //           if (lastTrackPoint != null) {
//   //             totalDistance += calculateDistance(
//   //               lastTrackPoint!.latitude,
//   //               lastTrackPoint!.longitude,
//   //               position.latitude,
//   //               position.longitude,
//   //             );
//   //           }
//   //
//   //           lastTrackPoint = geo.Position(
//   //             latitude: position.latitude,
//   //             longitude: position.longitude,
//   //             accuracy: 0,
//   //             altitude: 0,
//   //             altitudeAccuracy: 0,
//   //             heading: 0,
//   //             headingAccuracy: 0,
//   //             speed: 0,
//   //             speedAccuracy: 0,
//   //             timestamp: DateTime.now(),
//   //           );
//   //
//   //           segment.trkpts.add(trackPoint);
//   //           if (isFirstRun) {
//   //             track.trksegs.add(segment);
//   //             gpx.trks.add(track);
//   //             isFirstRun = false;
//   //           }
//   //
//   //           gpxString = GpxWriter().asString(gpx, pretty: true);
//   //           print("w100 $gpxString");
//   //
//   //           file?.writeAsStringSync(gpxString);
//   //         });
//   //   } catch (e) {
//   //     print("w100 ERRORRRR:   $e");
//   //   }
//   // }
//
//
//   double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//     double distanceInMeters = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
//     return (distanceInMeters / 1000) * 2; // Multiply the result by 2
//   }
//
//   Future<void> deleteDocument() async {
//     await FirebaseFirestore.instance
//         .collection('location')
//         .doc(userIdForLocation)
//         .delete()
//         .then(
//           (doc) => print("Document deleted"),
//       onError: (e) => print("Error updating document $e"),
//     );
//   }
//
//   Future<void> stopListening() async {
//     try {
//       //WakelockPlus.disable();
//       positionStream?.cancel();
//
//       Fluttertoast.showToast(
//           msg: "Total Distance: ${totalDistance.toStringAsFixed(2)} km",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.grey,
//           textColor: Colors.white,
//           fontSize: 16.0
//       );
//       SharedPreferences pref = await SharedPreferences.getInstance();
//       pref.setDouble("TotalDistance", totalDistance);
//     } catch (e) {
//       print("ERROR ${e.toString()}");
//     }
//   }
//
// }