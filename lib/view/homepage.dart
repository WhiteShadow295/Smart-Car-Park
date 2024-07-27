import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _welcomeMessage = 'Welcome Back,';
  final String _username = 'User !';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            padding: const EdgeInsets.only(right: 15.0),
            iconSize: 35.0,
            onPressed: () {
              // Navigator.pushNamed(context, '/login');
              // print('test');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Text(_welcomeMessage,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 15.0))),
              Container(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
                  child: Text(_username,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 30.0))),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey),
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: const Text('This is the homepage'),
          ),
          Container(
            color: Theme.of(context).colorScheme.primary,
            child: const Text('This is the homepage'),
          ),
        ],
      ),
    );
  }
}
