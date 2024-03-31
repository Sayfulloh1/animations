import 'dart:math';

import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const people = [
  Person(name: 'Azamatjon', age: 22, emoji: '😁'),
  Person(name: 'Bobur', age: 20, emoji: '👻'),
  Person(name: 'Jamoliddin', age: 12, emoji: '🥲'),
  Person(name: 'Kamronbek', age: 33, emoji: '☺️'),
  Person(name: 'Shavkatjon', age: 45, emoji: '👦'),
];

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: const Text(
          'People',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          var person = people[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondScreen(person: person)));
            },
            title: Text(
              person.name,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '${person.age} years old',
              style: const TextStyle(color: Colors.white),
            ),
            leading: Hero(
              flightShuttleBuilder: (
                flightContext,
                animation,
                flightDirection,
                fromHeroContext,
                toHeroContext,
              ) {
                switch (flightDirection) {
                  case HeroFlightDirection.push:
                    return ScaleTransition(
                      scale: animation.drive(
                        Tween<double>(begin: 0.0, end: 1.0)
                            .chain(CurveTween(curve: Curves.fastOutSlowIn)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: toHeroContext.widget,
                      ),
                    );
                  case HeroFlightDirection.pop:
                    return const Material(
                      color: Colors.transparent,
                      child: Text('🔥',style: TextStyle(fontSize: 40),),
                    );
                }
              },
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final Person person;

  const SecondScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text(
          'Details',
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 60),
              ),
            ),
            Text(
              person.name,
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              "${person.age} years old",
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
