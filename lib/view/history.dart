import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_car_park/services/auth_services.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: HistoryDetails(),
      ),
    );
  }
}

class HistoryDetails extends StatefulWidget {
  const HistoryDetails({super.key});

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  late String _carPlateNumber = '';
  late String _carModel = '';
  late String _timeIn = '';
  late String _timeOut = '';
  late dynamic _totalDuration;

  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('carpark_history');
  Map<String, dynamic> carparkData = {};

  @override
  void initState() {
    super.initState();
    listenToCarparkData(AuthService().getUserUid());
  }

  void listenToCarparkData(String uid) {
    _dbRef.orderByChild('uid').equalTo(uid).onValue.listen(
        (DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          Map<dynamic, dynamic> data =
              event.snapshot.value as Map<dynamic, dynamic>;

          data.forEach((key, value) {
            if (value != null && value is Map) {
              _carPlateNumber = value['car_plate_number'] ?? '-';
              _carModel = value['car_model'] ?? '-';

              List<dynamic>? checkInOutRecords =
                  value['checkInOutRecords'] as List<dynamic>?;
              if (checkInOutRecords != null && checkInOutRecords.isNotEmpty) {
                var latestRecord = checkInOutRecords
                    .lastWhere((record) => record != null, orElse: () => null);
                if (latestRecord != null && latestRecord is Map) {
                  _timeIn = latestRecord['checkInTime'] ?? '-';
                  _timeOut = latestRecord['checkOutTime'] ?? '-';

                  if (_timeOut == '-') {
                    _totalDuration =
                        DateTime.now().difference(DateTime.parse(_timeIn));
                  } else {
                    _totalDuration = DateTime.parse(_timeOut)
                        .difference(DateTime.parse(_timeIn));
                  }
                }
              }
            }
          });
        });
      }
    }, onError: (Object error) {
      print("Error listening to data: $error");
    });
  }

  @override
  void dispose() {
    _dbRef.onValue.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
      padding: const EdgeInsets.all(12.5),
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Text('Details',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('Car Plate Number: $_carPlateNumber'),
          const SizedBox(height: 5),
          Text('Car Model: $_carModel'),
          const SizedBox(height: 5),
          Text('Time In: $_timeIn'),
          const SizedBox(height: 5),
          Text('Time Out: $_timeOut'),
          const SizedBox(height: 5),
          Text('Total Duration: $_totalDuration'),
        ],
      ),
    );
  }
}