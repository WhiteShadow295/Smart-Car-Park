import 'package:flutter/material.dart';

class ParkingPage extends StatelessWidget {
  ParkingPage({super.key});
  final List<String> lotNames = ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 4'];
  final List<bool> lotStatus = [true, false, true, true];

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
            const Text(
              'Available',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
                ]),
            child: Column(
              children: [
                parkingIcon(),
                lotName(),
                const SizedBox(height: 15),
                statusInfo()
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
                    )
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
}
