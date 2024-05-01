import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application_1/pages/conts.dart';
import 'dart:math';
import 'package:flutter_application_1/pages/autocomplate_prediction.dart';
import 'package:flutter_application_1/pages/network_utilty.dart';
import 'package:flutter_application_1/pages/place_auto_complate_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

typedef void OnCoordinatesFetched(LatLng startLocation, LatLng endLocation);

class TaxiBuddyHomePage extends StatefulWidget {
  const TaxiBuddyHomePage({Key? key}) : super(key: key);

  @override
  _TaxiBuddyHomePageState createState() => _TaxiBuddyHomePageState();
}

class _TaxiBuddyHomePageState extends State<TaxiBuddyHomePage> {
  final List<Tab> _tabs = <Tab>[
    Tab(text: 'Search'),
    Tab(text: 'Map'),
  ];

  late List<Widget> _tabViews;

  @override
  void initState() {
    super.initState();
    _tabViews = <Widget>[
      SearchLocationScreen(
        onCoordinatesFetched: (startLocation, endLocation) {
          setState(() {
            _tabViews[1] = MapPage(startLocation: startLocation, endLocation: endLocation);
          });
        },
      ),
      MapPage(startLocation: LatLng(10.738175, 122.541184), endLocation: LatLng(10.713898, 122.552384)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: _tabViews,
        ),
      ),
    );
  }
}

class LocationUtils {
  static Future<LatLng?> getCoordinates(TextEditingController controller) async {
    final address = controller.text;
    final apiKey = GOOGLE_MAPS_API_KEY;
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final lat = jsonData['results'][0]['geometry']['location']['lat'];
      final lng = jsonData['results'][0]['geometry']['location']['lng'];

      return LatLng(lat, lng);
    } else {
      return null;
    }
  }

  static Future<LatLng?> getCoordinatesFromGoogleMaps(String address) async {
    final apiKey = GOOGLE_MAPS_API_KEY;
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final lat = jsonData['results'][0]['geometry']['location']['lat'];
      final lng = jsonData['results'][0]['geometry']['location']['lng'];

      return LatLng(lat, lng);
    } else {
      return null;
    }
  }
}

class SearchLocationScreen extends StatefulWidget {
  final OnCoordinatesFetched onCoordinatesFetched;

  const SearchLocationScreen({Key? key, required this.onCoordinatesFetched}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState(onCoordinatesFetched: onCoordinatesFetched);
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  List<AutocompletePrediction> placePredictions = [];
  List<AutocompletePrediction> destinationPlacePredictions = [];
  TextEditingController startingLocationController = TextEditingController();
  TextEditingController destinationLocationController = TextEditingController();
  LatLng? startingCoordinates;
  LatLng? destinationCoordinates;

  final OnCoordinatesFetched onCoordinatesFetched;

  _SearchLocationScreenState({required this.onCoordinatesFetched});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: startingLocationController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      placeAutoComplate(value);
                    } else {
                      setState(() {
                        placePredictions = [];
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Starting location',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: destinationLocationController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      placeAutoComlateDestination(value);
                    } else {
                      setState(() {
                        destinationPlacePredictions = [];
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Destination location',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    startingCoordinates = await LocationUtils.getCoordinatesFromGoogleMaps(startingLocationController.text);
                    destinationCoordinates = await LocationUtils.getCoordinatesFromGoogleMaps(destinationLocationController.text);
                    print('start $startingCoordinates');
                    print('destination $destinationCoordinates');
                    if (startingCoordinates != null && destinationCoordinates != null) {
                      onCoordinatesFetched(
                        LatLng(
                            startingCoordinates?.latitude ?? 0.0, 
                            startingCoordinates?.longitude ?? 0.0
                              ),
                        LatLng(
                            destinationCoordinates?.latitude ?? 0.0, 
                            destinationCoordinates?.longitude ?? 0.0
                        ),
                      );
                    }
                  },  
                  child: const Text('Get Coordinates'),
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
              Container(
                height: 200.0,
                child: ListView.builder(
                  itemCount: placePredictions.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(placePredictions[index].description!),
                      onTap: () {
                        selectLocation(placePredictions[index].description!, true);
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
              Container(
                height: 200.0,
                child: ListView.builder(
                  itemCount: destinationPlacePredictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(destinationPlacePredictions[index].description!),
                      onTap: () {
                        selectLocation(destinationPlacePredictions[index].description!, false);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void placeAutoComplate(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": GOOGLE_MAPS_API_KEY,
      },
    );
    String? response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  void placeAutoComlateDestination(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": GOOGLE_MAPS_API_KEY,
      },
    );
    String? response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          destinationPlacePredictions = result.predictions!;
        });
      }
    }
  }

  void selectLocation(String location, bool isStartingLocation) {setState(() {
      if (isStartingLocation) {
        startingLocationController.text = location;
        print(location);
        placePredictions = [];
      } else {
        destinationLocationController.text = location;
        print(location);
        destinationPlacePredictions = [];
      }
    });
  }
}

class MapPage extends StatefulWidget {
  final LatLng startLocation;
  final LatLng endLocation;

  const MapPage({Key? key, required this.startLocation, required this.endLocation}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState(startLocation: startLocation, endLocation: endLocation);
}

class _MapPageState extends State<MapPage> {
  final LatLng startLocation;
  final LatLng endLocation;

  _MapPageState({required this.startLocation, required this.endLocation});

  Location _locationController = new Location();
  final Completer<GoogleMapController> _mapController = 
      Completer<GoogleMapController>();
  LatLng _currentP = LatLng(10.738175, 122.541184);
  Map<PolylineId, Polyline> polylines = {};
  Map<MarkerId, Marker> markers = {};

  final MarkerId _currentLocationMarkerId = MarkerId("_currentLocation");
  final MarkerId _sourceLocationMarkerId = MarkerId("_sourceLocation");
  final MarkerId _destinationLocationMarkerId = MarkerId("_destinationLocation");

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((_) => {
getPolylinePoints().then((coordinates) => {
        generatePolyLineFromPoints(coordinates),
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: startLocation, zoom: 12),
        ));
      },
      initialCameraPosition: CameraPosition(target: startLocation, zoom: 12),
      markers: Set<Marker>.of(markers.values),
      polylines: Set<Polyline>.of(polylines.values),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted!= PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation!= null) {
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          print(_currentP);

          // Update the marker position
          markers[_currentLocationMarkerId] = Marker(
            markerId: _currentLocationMarkerId,
            icon: BitmapDescriptor.defaultMarker,
            position: _currentP,
          );
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      markers[_sourceLocationMarkerId] = Marker(
        markerId: _sourceLocationMarkerId,
        icon: BitmapDescriptor.defaultMarker,
        position: startLocation,
      );
      markers[_destinationLocationMarkerId] = Marker(
        markerId: _destinationLocationMarkerId,
        icon: BitmapDescriptor.defaultMarker,
        position: endLocation,
      );
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(startLocation.latitude, startLocation.longitude), // ORIGIN
      PointLatLng(endLocation.latitude, endLocation.longitude), // DESTINATION
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) { 
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    double totalDistance = 0.0;

    for( var i = 0; i < polylineCoordinates.length - 1; i++ ){
      totalDistance += calculateDistance(
          polylineCoordinates[i], polylineCoordinates[i+1]);
    }
    print('DISTANCE: $totalDistance km');
    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 7);
    setState(() {
      polylines[id] = polyline;
    });
  }

  double calculateDistance(LatLng point1, LatLng point2) {var lat1 = point1.latitude;
    var lon1 = point1.longitude;
    var lat2 = point2.latitude;
    var lon2 = point2.longitude;

    var R = 6371; // Radius of the earth in km
    var dLat = _deg2rad(lat2 - lat1);  // deg2rad below
    var dLon = _deg2rad(lon2 - lon1); 
    var a = 
        sin(dLat/2) * sin(dLat/2) +
            cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * 
            sin(dLon/2) * sin(dLon/2)
        ; 
    var c = 2 * atan2(sqrt(a), sqrt(1-a)); 
    var d = R * c; // Distance in km
    return d;
  }

  double _deg2rad(deg) {
    return deg * (pi/180);
  }
}