import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<String> imageUrls;
  final String sexPref;
  final String height;
  final String distance;
  final String bio;
  final String jobTitle;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.bio,
    required this.jobTitle,
    required this.height,
    required this.sexPref,
    required this.distance
  });

  @override
  List<Object?> get props => [
    id,
    name,
    age,
    imageUrls,
    bio,
    jobTitle,
    sexPref,
    distance,
    height
  ];

  static List<User> users = [
    User(
      id: 1,
      name: 'David',
      age: 28,
      imageUrls: const [
        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ],
      jobTitle: 'Gamer',
      bio: 'Test',
      sexPref: 'Straight',
      height: '5ft 7in',
      distance: '3.8 miles away'
    ),
    User(
      id: 2,
      name: 'Anna',
      age: 24,
      imageUrls: const [
        'https://images.pexels.com/photos/678783/pexels-photo-678783.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ],
      jobTitle: 'Gamer',
      bio: 'Test',
      sexPref: 'Straight',
      height: '5ft 3in',
      distance: '6.2 miles away'
    ),
    User(
      id: 3,
      name: 'David',
      age: 28,
      imageUrls: const [
        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ],
      jobTitle: 'Gamer',
      bio: 'Test',
      sexPref: 'Straight',
      height: '5ft 7in',
      distance: '3.8 miles away'
    ),
    User(
      id: 4,
      name: 'Anna',
      age: 24,
      imageUrls: const [
        'https://images.pexels.com/photos/678783/pexels-photo-678783.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ],
      jobTitle: 'Gamer',
      bio: 'Test',
      sexPref: 'Straight',
      height: '5ft 3in',
      distance: '6.2 miles away'
    ),
  ];
  
}