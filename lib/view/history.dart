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
      body: const HistoryDetails(),
    );
  }
}

class HistoryDetails extends StatefulWidget {
  const HistoryDetails({super.key});

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('carpark_history');
  late List<Map<String, dynamic>> _carparkDataList = [];
  bool _isLoading = true;
  bool _hasError = false;

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
          _carparkDataList = [];

          data.forEach((key, value) {
            if (value != null && value is Map) {
              Map<String, dynamic> carparkRecord = {
                'carPlateNumber': value['car_plate_number'] ?? '-',
                'carModel': value['car_model'] ?? '-',
                'checkInOutRecords':
                    value['checkInOutRecords'] as List<dynamic>? ?? [],
              };
              _carparkDataList.add(carparkRecord);
            }
          });

          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }, onError: (Object error) {
      print("Error listening to data: $error");
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    });
  }

  @override
  void dispose() {
    _dbRef.onValue.drain();
    super.dispose();
  }

  String calculateDuration(String timeIn, String timeOut) {
    if (timeOut == '-') {
      return DateTime.now()
          .difference(DateTime.parse(timeIn))
          .toString()
          .split('.')
          .first;
    } else {
      return DateTime.parse(timeOut)
          .difference(DateTime.parse(timeIn))
          .toString()
          .split('.')
          .first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return const Center(child: Text('Error fetching data'));
    }

    if (_carparkDataList.isEmpty) {
      return const Center(child: Text('No carpark history available'));
    }

    return ListView.builder(
      itemCount: _carparkDataList.length,
      itemBuilder: (context, index) {
        final carparkData = _carparkDataList[index];
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var record in carparkData['checkInOutRecords'])
                
                if (record != null)
                  CarparkHistoryWidget(
          
                    carPlateNumber: carparkData['carPlateNumber'] ?? '-',
                    carModel: carparkData['carModel'] ?? '-',
                    timeIn: record['checkInTime'] ?? '-',
                    timeOut: record['checkOutTime'] ?? '-',
                    totalDuration: calculateDuration(
                        record['checkInTime'], record['checkOutTime']),
                  ),
            ],
          ),
        );
      },
    );
  }
}

class CarparkHistoryWidget extends StatelessWidget {
  final String carPlateNumber;
  final String carModel;
  final String timeIn;
  final String timeOut;
  final String totalDuration;

  const CarparkHistoryWidget({
    super.key,
    required this.carPlateNumber,
    required this.carModel,
    required this.timeIn,
    required this.timeOut,
    required this.totalDuration,
  });

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
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 12.5, 20, 12.5),
      margin: const EdgeInsets.fromLTRB(5, 15, 5, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Details',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text('Car Plate Number: $carPlateNumber'),
          const SizedBox(height: 7),
          Text('Car Model: $carModel'),
          const SizedBox(height: 7),
          Text('Time In: $timeIn'),
          const SizedBox(height: 7),
          Text('Time Out: $timeOut'),
          const SizedBox(height: 7),
          Text('Total Duration: $totalDuration'),
        ],
      ),
    );
  }
}
