import 'package:eunity/models/models.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class Swiping extends StatefulWidget {
  const Swiping({Key? key});

  @override
  State<Swiping> createState() => _SwipingState();
}

class _SwipingState extends State<Swiping> with SingleTickerProviderStateMixin {
  bool isArrowPressed = false;
  late AnimationController _animationController;
  late Animation<double> _widthScaleAnimation;
  late Animation<double> _heightScaleAnimation;
  late Animation<double> _profilePositionAnimation;
  int currentUserIndex = 0;
  int interestIndex = 0;

  final List<String> testInterests = ['gaming', 'reading', 'running'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _widthScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.7,
    ).animate(_animationController);

    _heightScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.7,
    ).animate(_animationController);

    _profilePositionAnimation = Tween<double>(
      begin: 0.0,
      end: -110.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onArrowPressed() {
    setState(() {
      isArrowPressed = !isArrowPressed;
      if (isArrowPressed) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _onHeartPressed() {
    setState(() {
      if (currentUserIndex < User.users.length - 1) {
        currentUserIndex++;
      } else {
        // Optionally handle the case when there are no more users
        currentUserIndex = 0;
      }
    });
  }

  void _onPassPressed() {
    setState(() {
      if (currentUserIndex < User.users.length - 1) {
        currentUserIndex++;
      } else {
        // Optionally handle the case when there are no more users
        currentUserIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 1.5,
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0, _profilePositionAnimation.value),
                    child: Transform.scale(
                      scaleX: _widthScaleAnimation.value,
                      scaleY: _heightScaleAnimation.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Draggable(
                            feedback: UserCard(
                                user: User.users[currentUserIndex],
                                isArrowPressed: isArrowPressed,
                                OnArrowPressed: _onArrowPressed),
                            childWhenDragging: currentUserIndex + 1 < User.users.length
                                ? UserCard(
                                    user: User.users[currentUserIndex + 1],
                                    isArrowPressed: isArrowPressed,
                                    OnArrowPressed: _onArrowPressed)
                                : const SizedBox.shrink(),
                            child: UserCard(
                                user: User.users[currentUserIndex],
                                isArrowPressed: isArrowPressed,
                                OnArrowPressed: _onArrowPressed),
                            onDragEnd: (drag){
                                if(drag.velocity.pixelsPerSecond.dx < -500){
                                  print("Swipe left");
                                  _onPassPressed();
                                }
                                if(drag.velocity.pixelsPerSecond.dx > 500){
                                  print("Swipe right");
                                  _onHeartPressed();
                                }
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isArrowPressed)
                    Positioned(
                      top: (MediaQuery.of(context).size.height /
                              1.135*
                              _heightScaleAnimation.value) ,
                      child: Column(
                        children: [
                          InterestBuilder(user: User.users[currentUserIndex]),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0, right: 60.0),
                            child: UserHeaderInfo(
                                user: User.users[currentUserIndex],
                                textColor: Colors.black,
                                fontSize: 24,
                                ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: UserBio(
                                user: User.users[currentUserIndex],
                                textColor: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: ReactButtons(
        onHeartPressed: _onHeartPressed,
        onPassPressed: _onPassPressed,
      ),
    );
  }
}

class InterestBuilder extends StatelessWidget {
  final User user;

  InterestBuilder({
    super.key,
    required this.user,
  });

  final List<String> testInterests = ['Gaming', 'Reading', 'Cooking'];

  @override
  Widget build(BuildContext context) {
    Set<String> matchingStrings = testInterests.toSet().intersection(user.interests.toSet());

    // Calculate the number of items per row based on the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    int itemsPerRow = (screenWidth / 110).floor(); // 110 is the width + padding of each item

    // Divide interests into rows
    List<List<String>> rows = [];
    for (int i = 0; i < user.interests.length; i += itemsPerRow) {
      rows.add(user.interests.sublist(i, i + itemsPerRow > user.interests.length ? user.interests.length : i + itemsPerRow));
    }

    return Column(
      children: rows.map((row) {
        return SizedBox( // Use Container to adjust margin
          height: 55,
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0), // Gap of all interests from the left of screen
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: row.length,
              itemBuilder: (BuildContext context, int index) {
                String interest = row[index];
                bool isMatching = matchingStrings.contains(interest);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0), // Reduce the gap between each interest
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      isMatching
                          ? SizedBox(
                              width: 90,
                              child: rive.RiveAnimation.asset(
                                'assets/icons/MatchingInterest4.riv',
                                animations: ['Timeline 1'], // specify your animation name
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                              ),
                            )
                          : SizedBox(
                              width: 90,
                              child: rive.RiveAnimation.asset(
                                'assets/icons/NonMatchingInterest.riv',
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                              ),
                            ),
                      Positioned(
                        top: 32,
                        child: Text(
                          interest,
                          style: TextStyle(
                            color: isMatching ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}


class ReactButtons extends StatelessWidget {
  final VoidCallback onHeartPressed;
  final VoidCallback onPassPressed;

  const ReactButtons({
    super.key,
    required this.onHeartPressed,
    required this.onPassPressed,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPassPressed,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 236, 236, 236).withOpacity(.8),
            ),
            child: const Icon(Icons.clear_rounded, color: Colors.black),
          ),
        ),
        SizedBox(width: 30),
        GestureDetector(
          onTap: onHeartPressed,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF5C5C).withOpacity(.8),
            ),
            child: const Icon(Icons.favorite, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  final bool isArrowPressed;
  final VoidCallback OnArrowPressed;

  const UserCard({
    Key? key,
    required this.user,
    required this.isArrowPressed,
    required this.OnArrowPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.175,
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
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            if (!isArrowPressed)
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: OnArrowPressed,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: const Icon(Icons.arrow_upward, color: Colors.white),
                  ),
                ),
              ),
            if (!isArrowPressed)
              Positioned(
                bottom: 110,
                left: 20,
                child: UserNameAge(user: user, textColor: Colors.white),
              ),
            if (!isArrowPressed)
              Positioned(
                bottom: 90,
                left: 20,
                child: UserHeaderInfo(user: user, textColor: Colors.white, fontSize: 20),
              ),
            if (isArrowPressed)
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: OnArrowPressed,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF5C5C).withOpacity(.8),
                    ),
                    child:
                        const Icon(Icons.arrow_downward, color: Colors.white),
                  ),
                ),
              ),
            if (isArrowPressed)
              Positioned(
                bottom: 30,
                left: 20,
                child: UserNameAge(user: user, textColor: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

class UserNameAge extends StatelessWidget {
  final User user;
  final Color textColor;

  const UserNameAge({super.key, required this.user, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${user.name}, ${user.age}',
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: textColor,
          ),
    );
  }
}

class UserHeaderInfo extends StatelessWidget {
  final User user;
  final Color textColor;
  final double fontSize;

  const UserHeaderInfo(
      {super.key, required this.user, required this.textColor, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${user.sexPref} | ${user.height} | ${user.distance}',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: textColor,
            fontSize: fontSize,
          ),
    );
  }
}

class UserBio extends StatelessWidget {
  final User user;
  final Color textColor;

  const UserBio({Key? key, required this.user, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      child: Text(
        '${user.bio}',
        softWrap: true,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: textColor,
              fontSize: 17,
              height: 1.75,
            ),
      ),
    );
  }
}
