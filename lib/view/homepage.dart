import 'package:flutter/material.dart';
import 'package:smart_car_park/services/auth_services.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _welcomeMessage = 'Welcome Back,';
  final String _username = AuthService().getCurrentUser();
  final String _title = 'ParkWise';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            padding: const EdgeInsets.only(right: 15.0),
            iconSize: 35.0,
            onPressed: () async{
              await AuthService().signout(context: context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).colorScheme.inversePrimary,
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(_welcomeMessage,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 15.0)),
                Text(_username,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 25.0)),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.inversePrimary,
                      Colors.white
                    ]),
              ),
              child: Container(
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
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.local_parking_rounded),
                          iconSize: 45.0,
                          onPressed: () {
                            Navigator.pushNamed(context, '/parking');
                          },
                        ),
                        const Text('Parking Lots'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.directions_car_rounded),
                          iconSize: 45.0,
                          onPressed: () {
                            Navigator.pushNamed(context, '/car_info');
                          },
                        ),
                        const Text('Car Information'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.history_rounded),
                          iconSize: 45.0,
                          onPressed: () {
                            print('test');
                          },
                        ),
                        const Text('History'),
                      ],
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 12.5),
          const Details()
        ],
      ),
    );
  }
}

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final String _carPlateNumber = 'ABC1234';
  final String _carModel = 'Proton X70';
  final String _location = 'Slot 1';
  final String _timeIn = '12:00 PM';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Details',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('Car Plate Number : $_carPlateNumber'),
          const SizedBox(height: 5),
          Text('Car Model : $_carModel'),
          const SizedBox(height: 5),
          Text('Car Park Location : $_location'),
          const SizedBox(height: 5),
          Text('Time In : $_timeIn'),
          const SizedBox(height: 5),
          const Text('Time Out : -'),
          const SizedBox(height: 5),
          const Text('Total Duration : -'),
        ],
      ),
    );
  }
}
