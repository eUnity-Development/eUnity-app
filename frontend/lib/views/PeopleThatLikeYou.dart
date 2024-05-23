import 'package:flutter/material.dart';
import 'package:frontend/widgets/PersonThatLikesYouTile.dart';

class PeopleThatLikeYou extends StatefulWidget {
  const PeopleThatLikeYou({super.key});

  @override
  State<PeopleThatLikeYou> createState() => _PeopleThatLikeYouState();
}

class _PeopleThatLikeYouState extends State<PeopleThatLikeYou> {
  final List profileData = [];
  final Map<String, String> stephanieBrown = {
    'name': 'Stephanie Brown',
    'age': '27',
    'distance': '3.8',
    'matchScore': '87',
    'imageURL': 'assets/FakePeople/StephanieBrown.png'
  };
  final Map<String, String> claraSmith = {
    'name': 'Clara Smith',
    'age': '28',
    'distance': '4.1',
    'matchScore': '87',
    'imageURL': 'assets/FakePeople/ClaraSmith.png'
  };
  final Map<String, String> erinGreen = {
    'name': 'Erin Green',
    'age': '24',
    'distance': '2.1',
    'matchScore': '83',
    'imageURL': 'assets/FakePeople/ErinGreen.png'
  };
  final Map<String, String> mollyTaylor = {
    'name': 'Molly Taylor',
    'age': '23',
    'distance': '7.8',
    'matchScore': '81',
    'imageURL': 'assets/FakePeople/MollyTaylor.png'
  };

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadUpdate() async {
    profileData.add(stephanieBrown);
    profileData.add(claraSmith);
    profileData.add(erinGreen);
    profileData.add(mollyTaylor);
  }

  void firstLoad() {
    loadUpdate();
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: () => loadUpdate(),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (profileData.isEmpty && index == 0) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (index >= profileData.length - 5) {
            if (index >= profileData.length) {
              return null;
            }
            return PersonThatLikesYouTile(
              userData: profileData[index],
            );
          }
          return PersonThatLikesYouTile(
            userData: profileData[index],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    firstLoad();
    return Scaffold(
        body: profileData.isNotEmpty
            ? _buildList()
            : Center(
                child: Text("No Profiles Here!"),
              ));
  }
}
