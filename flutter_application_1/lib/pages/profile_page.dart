import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/activity_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/map_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            width: double.infinity,
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
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(25),
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.asset('assets/images/profile_pic.png'),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset('assets/images/edit_pic.png'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Jane Dela Cruz',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      profileInfo("Username: ", "Jane Dela Cruz"),
                      const SizedBox(height: 30),
                      profileInfo("Email: ", "janedelacruz@gmail.com"),
                      const SizedBox(height: 30),
                      profileInfo("Contact Number: ", "09090909090"),
                      const SizedBox(height: 30),
                      profileInfo("Address: ", "Iloilo City"),
                      const SizedBox(height: 15),
                      const Divider(height: 15, indent: 20, endIndent: 20),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          ClickableCircle(),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Receive messages',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          ClickableCircle(),
                        ],
                      ),
                    ],
                  ),
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

  Widget profileInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class ClickableCircle extends StatefulWidget {
  @override
  _ClickableCircleState createState() => _ClickableCircleState();
}

class _ClickableCircleState extends State<ClickableCircle> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isClicked = !_isClicked;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
            width: 2,
          ),
          shape: BoxShape.circle,
          color: _isClicked ? const Color.fromARGB(255, 13, 177, 27) : Colors.grey[50],
        ),
      ),
    );
  }
}
