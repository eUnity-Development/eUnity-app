import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// TODO: ADD SKIP BUTTON IN NAVBAR!!!
class PushedScreenTopBar extends StatefulWidget implements PreferredSizeWidget {
  final bool? hasArrow;
  final bool? hasSkip;
  final bool? isPremium;
  final VoidCallback? onSkip;
  const PushedScreenTopBar({super.key, this.hasArrow, this.hasSkip, this.onSkip, this.isPremium});

  @override
  State<PushedScreenTopBar> createState() => _PushedScreenTopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PushedScreenTopBarState extends State<PushedScreenTopBar> {
  @override
  Widget build(BuildContext context) {
    bool isPremium = widget.isPremium ?? false;
    bool hasArrow = widget.hasArrow ?? true;
    bool hasSkip = widget.hasSkip ?? false;
    VoidCallback onTapSkip = widget.onSkip ?? () => {print('Add function for onSkip param')};

    String logoLocation = isPremium ? "assets/premium/premium-logo.png" : "assets/e-unity-logo-and-name.png";

    return AppBar(
      title: Stack(
        children: [
          if (hasArrow)
          Positioned(
              left: 0,
              top: 0,
              child: GestureDetector(
                child: SizedBox(
                  child:
                      SvgPicture.asset("assets/NavBarUI/icon-arrow-left.svg"),
                  height: 40,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )),
          Container(
            child: Center(
              child: SizedBox(
                width: isPremium ? 220 : 120,
                child: Image.asset(logoLocation),
              ),
            ),
          ),
          if (hasSkip)
          Positioned(
          right: 0,
          child: GestureDetector(  
            onTap: onTapSkip,  
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
    );
  }
}
