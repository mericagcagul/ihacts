import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';

  final response = await http.get(Uri.parse(googleLocationsURL));
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode};'
        '${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}

class Locations {
  late List<Offices> offices;
  late List<Regions> regions;

  Locations({required this.offices, required this.regions});

  Locations.fromJson(Map<String, dynamic> json) {
    if (json['offices'] != null) {
      offices = <Offices>[];
      json['offices'].forEach((v) {
        offices.add(new Offices.fromJson(v));
      });
    }
    if (json['regions'] != null) {
      regions = <Regions>[];
      json['regions'].forEach((v) {
        regions.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    late final Map<String, dynamic> data = <String, dynamic>{};
    if (this.offices != null) {
      data['offices'] = this.offices.map((v) => v.toJson()).toList();
    }
    if (this.regions != null) {
      data['regions'] = this.regions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offices {
  late String address;
  late String id;
  late String image;
  late double lat;
  late double lng;
  late String name;
  late String phone;
  late String region;

  Offices(
      {required this.address,
      required this.id,
      required this.image,
      required this.lat,
      required this.lng,
      required this.name,
      required this.phone,
      required this.region});

  Offices.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    id = json['id'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    name = json['name'];
    phone = json['phone'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    late final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = this.address;
    data['id'] = this.id;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['region'] = this.region;
    return data;
  }
}

class Regions {
  late Coords coords;
  late String id;
  late String name;
  late double zoom;

  Regions(
      {required this.coords,
      required this.id,
      required this.name,
      required this.zoom});

  Regions.fromJson(Map<String, dynamic> json) {
    coords = (json['coords'] != null ? Coords.fromJson(json['coords']) : null)!;
    id = json['id'];
    name = json['name'];
    zoom = json['zoom'];
  }

  Map<String, dynamic> toJson() {
    late final Map<String, dynamic> data = <String, dynamic>{};
    if (this.coords != null) {
      data['coords'] = this.coords.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['zoom'] = this.zoom;
    return data;
  }
}

class Coords {
  late double lat;
  late double lng;

  Coords({required this.lat, required this.lng});

  Coords.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
