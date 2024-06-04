import 'package:flutter/material.dart';
import 'package:frontend/models/models.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height *1.5,
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
                            user: User.users[0],
                            isArrowPressed: isArrowPressed,
                            OnArrowPressed: _onArrowPressed
                          ),
                          childWhenDragging: UserCard(
                            user: User.users[1],
                            isArrowPressed: isArrowPressed,
                            OnArrowPressed: _onArrowPressed
                          ),
                          child: UserCard(
                            user: User.users[0],
                            isArrowPressed: isArrowPressed,
                            OnArrowPressed: _onArrowPressed
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isArrowPressed)
                Positioned(
                    top: (MediaQuery.of(context).size.height / 1.23 * _heightScaleAnimation.value) + 100,
                    child: Column(
                      children: [
                          UserHeaderInfo(user: User.users[0], textColor: Colors.black),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: UserBio(user: User.users[0], textColor: Colors.black),
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
      floatingActionButton: ReactButtons(),
    );
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 236, 236, 236).withOpacity(.8),
            ),
            child: const Icon(Icons.clear_rounded, color: Colors.black),
          ),
          SizedBox(width: 30),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF5C5C).withOpacity(.8),
            ),
            child: const Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),
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
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
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
            if(!isArrowPressed)
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
                  child: UserHeaderInfo(user: user, textColor: Colors.white),
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
                  child: const Icon(Icons.arrow_downward, color: Colors.white),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${user.name}, ${user.age}',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: textColor,
              ),
        ),
      ],
    );
  }
}

class UserHeaderInfo extends StatelessWidget {
  final User user;
  final Color textColor;

  const UserHeaderInfo({super.key, required this.user, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${user.sexPref} | ${user.height} | ${user.distance}',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: textColor,
                fontSize: 18,
              ),
        ),
      ],
    );
  }
}

class UserBio extends StatelessWidget {
  final User user;
  final Color textColor;

  const UserBio({Key? key, required this.user, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${user.bio}',
          softWrap: true,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: textColor,
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}
