import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gpx/gpx.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/Globals.dart';
import '../Views/HomePage.dart';
import 'package:location/location.dart' as loc;

var gpx;
var track;
var segment;
var trkpt;
var long,lat;

String gpxString="";
StreamSubscription<Position>? _positionStreamSubscription;

final loc.Location location = loc.Location();
StreamSubscription<loc.LocationData>? _locationSubscription;

Future<void> listenLocation() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  userIdForLocation = pref.getString("userNames") ?? "USER";
  try {
    await Firebase.initializeApp();
    gpx = new Gpx();
    track = new Trk();
    segment = new Trkseg();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    print("W100 Start");
    final date = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final downloadDirectory = await getDownloadsDirectory();
    final filePath = "${downloadDirectory!.path}/track$date.gpx";

    File file = new File(filePath);
    bool isFirstRun = !file.existsSync();

    if (isFirstRun) {
      file.createSync();
    } else {
      Gpx existingGpx = GpxReader().fromString(file.readAsStringSync());
      gpx.trks.add(existingGpx.trks[0]);
      track = gpx.trks[0];
      segment = new Trkseg();
      track.trksegs.add(segment);
    }

    late LocationSettings locationSettings;
    locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 100,
      forceLocationManager: true,
      intervalDuration: const Duration(seconds: 3),
    );

    Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) async {
      print("W100 Repeat");
      await FirebaseFirestore.instance.collection('location').doc(userIdForLocation.toString()).set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'name': userIdForLocation.toString(),
        'isActive': true
      }, SetOptions(merge: true));
      long = position.longitude.toString();
      lat = position.latitude.toString();
      final trackPoint = Wpt(
        lat: position.latitude,
        lon: position.longitude,
        time: DateTime.now(),
      );

      segment.trkpts.add(trackPoint);

      if (isFirstRun) {
        track.trksegs.add(segment);
        gpx.trks.add(track);
        isFirstRun = false;
      }

      gpxString = GpxWriter().asString(gpx, pretty: true);
      print("W100 $gpxString");

      file.writeAsStringSync(gpxString);
    });
    print("W100 END");
  } catch (e) {
    print('W100 An error occurred: $e');
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
Timer? _timer;
void stopListeningLocation() {
  _timer?.cancel();
  _timer = null;
  print("Stopped listening to location updates");
}

getLocation() async {
  try {
    final Position position = await Geolocator.getCurrentPosition();
    await FirebaseFirestore.instance.collection('location').doc(userIdForLocation).set({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'name': name.toString(),
      'isActive': false
    }, SetOptions(merge: true));
  } catch (e) {
    print(e);
  }
}

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