import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eunity/classes/DesignVariables.dart';

class PersonThatLikesYouTile extends StatelessWidget {
  final Map<String, String> userData;
  const PersonThatLikesYouTile({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(64, 0, 0, 0),
                          spreadRadius: 0,
                          blurRadius: 4 * DesignVariables.widthConversion,
                          offset:
                              Offset(0, 4 * DesignVariables.heightConversion),
                        ),
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(userData['imageURL']!),
                    radius: 80 * DesignVariables.widthConversion,
                  ),
                ),
                SizedBox(
                  width: 10 * DesignVariables.widthConversion,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userData['name']!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    Text(
                      "${userData['age']} Years Old, ${userData['distance']} Miles Away",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(192, 0, 0, 0)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 1, color: DesignVariables.greyLines),
                          color: DesignVariables.primaryRed),
                      height: 51 * DesignVariables.heightConversion,
                      width: 207 * DesignVariables.widthConversion,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: SvgPicture.asset(
                                "assets/NavBarUI/icon-filled-heart.svg",
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 8 * DesignVariables.widthConversion,
                            ),
                            Text(
                              "Match Score: ${userData['matchScore']}%",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 5 * DesignVariables.heightConversion,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1, color: DesignVariables.greyLines),
                            color: DesignVariables.offWhite),
                        height: 51 * DesignVariables.heightConversion,
                        width: 207 * DesignVariables.widthConversion,
                        child: Center(
                          child: Text(
                            "View Profile",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ))
                  ],
                )
              ]),
        ),
        Container(height: 1, color: DesignVariables.greyLines)
      ]),
    );
  }
}
