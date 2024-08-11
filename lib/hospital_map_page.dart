import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalMapPage extends StatefulWidget {
  final String province;

  HospitalMapPage({required this.province});

  @override
  _HospitalMapPageState createState() => _HospitalMapPageState();
}

class _HospitalMapPageState extends State<HospitalMapPage> {
  late GoogleMapController mapController;

  final Map<String, LatLng> provinceLocations = {
  'Aceh': LatLng(4.702098841272841, 96.76644066898518),
  'Bali': LatLng(-8.42035755747736, 115.1618535355941),
  'Banten': LatLng(-6.3753091347909, 105.97635391502266),
  'Bengkulu': LatLng(-3.559024564797449, 102.28243729921252),
  'DI Yogyakarta': LatLng(-7.881531280864178, 110.45274493311933),
  'DKI Jakarta': LatLng(-6.194881428369122, 106.82332583671904),
  'Gorontalo': LatLng(0.6956201934183098, 122.47229247820786),
  'Jambi': LatLng(-1.5104717319510903, 102.45708327865013),
  'Jawa Barat': LatLng(-7.101958055534151, 107.74156899304458),
  'Jawa Tengah': LatLng(-7.167124175694929, 110.0359021292825),
  'Jawa Timur': LatLng(-7.514733870475318, 112.30650786884405),
  'Kalimantan Barat': LatLng(-0.3125176638772268, 111.47631624408493),
  'Kalimantan Selatan': LatLng(-3.0779145597275286, 115.2747107604111),
  'Kalimantan Tengah': LatLng(-1.7404631631728016, 113.22876825882116),
  'Kalimantan Timur': LatLng(0.5826767443342081, 116.50144351277973),
  'Kalimantan Utara': LatLng(3.0204642016903156, 116.08523935989706),
  'Kep. Bangka Belitung': LatLng(-2.7157010875676724, 106.477554847288),
  'Kep. Riau': LatLng(3.9370374607438947, 108.18387035358393),
  'Lampung': LatLng(-4.5478183432919685, 105.35981853060733),
  'Maluku': LatLng(-3.2407159201750386, 130.14769593791956),
  'Maluku Utara': LatLng(1.5777736077796152, 127.78336684314442),
  'Nusa Tenggara Barat': LatLng(-8.683627151918486, 117.3309199372082),
  'Nusa Tenggara Timur': LatLng(-8.637949508231685, 121.08944688020202),
  'Papua': LatLng(-4.27610798771543, 138.07332365247504),
  'Papua Barat': LatLng(-1.3396136260733997, 133.1146123329231),
  'Riau': LatLng(0.2888248255431977, 101.67994455146962),
  'Sulawesi Barat': LatLng(-2.8299586183298264, 119.17006432753242),
  'Sulawesi Selatan': LatLng(-3.676374333192703, 119.93937930024519),
  'Sulawesi Tengah': LatLng(-1.453728391547582, 121.40191586674159),
  'Sulawesi Tenggara': LatLng(-4.101742248892819, 122.16597470770384),
  'Sulawesi Utara': LatLng(0.6254133314433467, 123.90463172618148),
  'Sumatera Barat': LatLng(-0.7437806113644791, 100.7848242621868),
  'Sumatera Selatan': LatLng(-3.3252871425525954, 103.83423841717057),
  'Sumatera Utara': LatLng(2.1094960686293627, 99.47655577287289),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peta ${widget.province}'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: provinceLocations[widget.province] ?? LatLng(0.0, 0.0),
          zoom: 10.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
