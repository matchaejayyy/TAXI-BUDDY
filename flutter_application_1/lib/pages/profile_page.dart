import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/activity_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/map_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Container( //main children 1 on the upper yellow
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25), //so the text wont be at the very edge of the yellow
            width: double.infinity, // Set width to fill the entire screen
            height: 100,
            decoration: const BoxDecoration(color: Colors.amber),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "PROFILE",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                SizedBox(height: 10,),
                Row(
                  children: [
                   
                

    
                  ],
                ),
              ],
            ),
          ),

        
        ],
      ),
      bottomNavigationBar: SizedBox(
  height: 60,
  child: BottomNavigationBar(
    onTap: (index) {
      setState(() {
        selectedIndex = index;
      });

      // Navigate to the corresponding page based on the selected index
      switch (index) {
        case 0:
          // Navigate to the Home page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          break;
        case 1:
          // Navigate to the Map page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaxiBuddyHomePage()),
          );
          break;
        case 2:
          // Navigate to the Activity page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ActivityPage()),
          );
          break;
        case 3:
          // Navigate to the Profile page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
          break;
      }
    },
    currentIndex: selectedIndex,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.place),
        label: 'Map',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label: 'Activity',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.grey[50],
    unselectedItemColor: Colors.black87.withOpacity(0.75),
    backgroundColor: Colors.amber,
    iconSize: 20,
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold
    ),
    unselectedFontSize: 15,
    selectedFontSize: 15,
  ),
),

    );
  }

  Row buildFileRowSub(String price) {
    return Row(
                          children: [
                            RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(197, 0, 0, 0),
                              ),
                              children: [
                                const TextSpan(
                                  text: "More Info ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(255, 0, 141, 59),
                                ),
                                ),
                                const TextSpan(
                                  text: "Estimated price ",
                                ),
                                TextSpan(
                                  text: price,
                                ),
                              ],
                            ),
                          ),
                          ],
                        );
  }

  Row buildFileRow(String place, String time) {
    return Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: place,
                                  ),
                                  TextSpan(
                                    text: time,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
  }

  Column buildFileColumn(String image) {
    return Column(
                    children: [
                      Container(
                        height:90,
                        width: 90,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 235, 133, 0), // Outer border color
                            width: 4, // Outer border width
                          ),
                          borderRadius: BorderRadius.circular(55), // Border radius
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.amber, // Inner border color
                              spreadRadius: -1, // Negative value to create an inner border
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(14),
                        child: Image.asset('assets/images/$image.png'),
                      )
                    ],
                  );
  }
}
