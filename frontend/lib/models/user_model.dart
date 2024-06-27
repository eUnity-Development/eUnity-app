import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final List<String> imageUrls;
  final List<String> interests;
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
    required this.interests,
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
    interests,
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
      bio: "Bookworm by day, trailblazer by weekend. I'm equally at home lost in a gripping novel or conquering new peaks. When I'm not adventuring outdoors, you'll find me cozying up to a good movie or diving into the virtual worlds of gaming.",
      sexPref: 'Straight',
      height: '5ft 7in',
      distance: '3.8 miles away',
      interests: ['Gaming', 'Reading', 'Cooking', 'Testing', 'Running']
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
      distance: '6.2 miles away',
      interests: ['Gaming', 'Reading', 'Cooking']
    ),
    User(
      id: 3,
      name: 'Dennis',
      age: 28,
      imageUrls: const [
        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ],
      jobTitle: 'Gamer',
      bio: 'Test',
      sexPref: 'Straight',
      height: '5ft 7in',
      distance: '3.8 miles away',
      interests: ['Gaming', 'Reading', 'Cooking']
    ),
    User(
      id: 4,
      name: 'Olivia',
      age: 24,
      imageUrls: const [
        'https://images.pexels.com/photos/678783/pexels-photo-678783.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
      ],
      jobTitle: 'Gamer',
      bio: 'Test',
      sexPref: 'Straight',
      height: '5ft 3in',
      distance: '6.2 miles away',
      interests: ['Gaming', 'Reading', 'Cooking']
    ),
  ];
  
}