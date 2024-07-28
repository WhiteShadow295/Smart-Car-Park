import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _welcomeMessage = 'Welcome Back,';
  final String _username = 'User !';
  final String _title = 'Car Parking System';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            padding: const EdgeInsets.only(right: 15.0),
            iconSize: 35.0,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
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
                            print('test');
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
                            print('test');
                          },
                        ),
                        const Text('Car Information'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.local_parking_rounded),
                          iconSize: 45.0,
                          onPressed: () {
                            print('test');
                          },
                        ),
                        const Text('Parking Lots'),
                      ],
                    ),
                  ],
                ),
              )),
          Container(
            color: Theme.of(context).colorScheme.primary,
            child: const Text('This is the homepage'),
          ),
        ],
      ),
    );
  }
}
