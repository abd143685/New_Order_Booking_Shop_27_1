import 'dart:async';
import 'dart:io';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:gpx/gpx.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../API/Globals.dart';
import '../Views/HomePage.dart';
import 'package:location/location.dart' as loc;
import 'package:carp_background_location/carp_background_location.dart';

import '../main.dart';

var gpx;
var track;
var segment;
var trkpt;
var longi;
var lat;

String gpxString="";
//StreamSubscription<Position>? _positionStreamSubscription;


//StreamSubscription<Position>? positionStream;
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





class LocationService {
  late StreamSubscription<LocationDto> locationSubscription;
  late Stream<LocationDto> locationStream;
  String? userIdForLocation;
  Gpx gpx = Gpx();
  Trk track = Trk();
  Trkseg segment = Trkseg();
  DateTime date = DateTime.now();
  File? file;
  bool isFirstRun = false;
  bool isConnected = false;

  LocationService() {
    Firebase.initializeApp();
    init();

  }

  Future<void> init() async {
    final downloadDirectory = await getDownloadsDirectory();
    SharedPreferences pref = await SharedPreferences.getInstance();
    userIdForLocation = pref.getString("userNames") ?? "USER";
    final filepath = "${downloadDirectory!.path}/track${DateFormat('dd-MM-yyyy').format(date)}.gpx";
    file = File(filepath);
    isFirstRun = !file!.existsSync();
  }

  Future<void> listenLocation() async {
    gpx = new Gpx();
    track = new Trk();
    segment = new Trkseg();
    isConnected = await isInternetConnected();
    try{
      WakelockPlus.enabled;
      AndroidSettings settings = const AndroidSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        interval: 1,
        distanceFilter: 1,
      );

      if (isFirstRun) {
        file!.createSync();
      } else {
        Gpx existingGpx = GpxReader().fromString(file!.readAsStringSync());
        gpx.trks.add(existingGpx.trks[0]);
        track = gpx.trks[0];
        segment = new Trkseg();
        track.trksegs.add(segment);
      }

      LocationManager().interval = settings.interval;
      LocationManager().distanceFilter = settings.distanceFilter;
      LocationManager().accuracy = settings.accuracy;
      LocationManager().notificationTitle = 'Running Location Service';

      await LocationManager().start();
      StreamSubscription<LocationDto>? locationSubscription =
      LocationManager().locationStream.listen((LocationDto position) async {
        isConnected = await isInternetConnected();
        if(isConnected){
          await FirebaseFirestore.instance.collection('location').doc(userIdForLocation.toString()).set({
            'latitude': position.latitude,
            'longitude': position.longitude,
            'name': userIdForLocation.toString(),
            'isActive': true
          }, SetOptions(merge: true));
        }
        print("w100 'Longitute $longi Latitute $lat'");
        final trackPoint = Wpt(
          lat: position.latitude,
          lon: position.longitude,
          time: DateTime.now(),
        );

        segment.trkpts.add(trackPoint);
        if(isFirstRun){
          track.trksegs.add(segment);
          gpx.trks.add(track);
          isFirstRun = false;
        }

        gpxString = GpxWriter().asString(gpx,pretty: true);
        print("w100 $gpxString");

        file?.writeAsStringSync(gpxString);
      });
    }catch (e){
      print("w100 ERRORRRR:   $e");
    }
  }


  deleteDocument() async {
    await FirebaseFirestore.instance
        .collection('location')
        .doc(userIdForLocation)
        .delete()
        .then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

  Future<void> stopListening() async {
    WakelockPlus.disable();
    isConnected = await isInternetConnected();
    if(isConnected){
      deleteDocument();
    }
    LocationManager().stop();
    locationSubscription.cancel();
  }
}