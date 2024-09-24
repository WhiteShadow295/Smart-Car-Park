import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class ParkingPage extends StatefulWidget {
  ParkingPage({super.key});

  @override
  _ParkingPageState createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingPage> {
  final List<String> lotNames = ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 4'];
  List<bool> lotStatus = [
    true,
    true,
    true,
    true
  ]; // Default values before fetching

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("Carpark");

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    // Listening for changes in the Firebase Realtime Database
    _databaseReference.onValue.listen((event) {
      final Map<dynamic, dynamic>? data =
          event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        // Updating the lot status list based on the data fetched
        setState(() {
          lotStatus = [
            data['Slot_1'] as bool,
            data['Slot_2'] as bool,
            data['Slot_3'] as bool,
            data['Slot_4'] as bool,
          ];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Park Availability'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            statusBox(),
            const SizedBox(height: 20),
            const Text(
              'The car park is currently:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              _getAvailabilityText(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _getAvailabilityColor(),
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  Container statusBox() {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          parkingIcon(),
          lotName(),
          const SizedBox(height: 15),
          statusInfo(),
        ],
      ),
    );
  }

  Row statusInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
              width: 15,
              height: 15,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green,
                shape: BoxShape.rectangle,
              ),
            ),
            const Text('Available'),
          ],
        ),
        Row(
          children: [
            Container(
              width: 15,
              height: 15,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
                shape: BoxShape.rectangle,
              ),
            ),
            const Text('Occupied'),
          ],
        ),
      ],
    );
  }

  Row lotName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: lotNames.map((name) {
        return Text(name);
      }).toList(),
    );
  }

  Row parkingIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: lotStatus.map((status) {
        return Container(
          width: 30,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _getColor(status),
            shape: BoxShape.rectangle,
          ),
        );
      }).toList(),
    );
  }

  Color _getColor(bool status) {
    return status ? Colors.green : Colors.red;
  }

  int _getCarparkNum() {
    int occupiedCount = lotStatus.where((status) => status == false).length;
    return occupiedCount;
  }

  // Determine the availability text based on the lot status
  String _getAvailabilityText() {
    int occupiedCount = _getCarparkNum();

    if (occupiedCount == 4) {
      return 'Occupied';
    } else if (occupiedCount == 3) {
      return 'Almost Full';
    } else {
      return 'Available';
    }
  }

  // Determine the color of the availability text
  Color _getAvailabilityColor() {
    int occupiedCount = _getCarparkNum();

    if (occupiedCount == 4) {
      return Colors.red;
    } else if (occupiedCount == 3) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
