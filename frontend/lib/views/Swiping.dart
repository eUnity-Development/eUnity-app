import 'package:flutter/material.dart';
import 'package:frontend/models/models.dart';

class Swiping extends StatefulWidget {
  const Swiping({super.key});

  @override
  State<Swiping> createState() => _CreatePostState();
}

class _CreatePostState extends State<Swiping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: const customAppBar(),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Stack(children: [
          Draggable(
            child: UserCard(user: User.users[0]),
            feedback: UserCard(user: User.users[0]),
            childWhenDragging: UserCard(user: User.users[1]),
          ),
          ReactButtons(),
        ]));
  }
}

class ReactButtons extends StatelessWidget {
  const ReactButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 140, right: 140),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 236, 236, 236).withOpacity(.8),
              ),
              child: Icon(Icons.clear_rounded, color: Colors.black),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5C5C).withOpacity(.8),
              ),
              child: Icon(Icons.favorite, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.23,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(user.imageUrls[0]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: const Offset(3, 3),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )),
              ),
              Positioned(
                bottom: 110,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.name}, ${user.age}',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Colors.white,
                                )),
                    Text('${user.sexPref} | ${user.height} | ${user.distance}',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Colors.white, fontSize: 18))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
