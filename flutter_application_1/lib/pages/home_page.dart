import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/activity_page.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_application_1/pages/fillup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Container(
            //main children 1 on the upper yellow
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal:
                    15), //so the text wont be at the very edge of the yellow
            width: double.infinity, // Set width to fill the entire screen
            height: 160,
            decoration: const BoxDecoration(color: Colors.amber),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          hintText: "Search",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 133, 0),
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                        icon: Icon(
                          Icons.qr_code_scanner,
                          size: 15,
                          color: Colors.grey[50],
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildFileColumn('taxi-home'),
                  buildFileColumn('map-home'),
                  GestureDetector(
                    onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Fillup()),
                     );
                    },
                    child: buildFileColumn('help-home'),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(
                              255, 235, 133, 0), // Outer border color
                          width: 4, // Outer border width
                        ),
                        borderRadius:
                            BorderRadius.circular(25), // Border radius
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.amber, // Inner border color
                            spreadRadius:
                                -1, // Negative value to create an inner border
                          ),
                        ],
                      ),
                      child: const Text(
                        "Activities",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                indent: 20,
                endIndent: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 250,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 5,
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Recent",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    buildFileRow("CPU - ROB JARO", " (8 mins)"),
                    const SizedBox(
                      height: 5,
                    ),
                    buildFileRowSub("₱95 - ₱105"),
                    const SizedBox(
                      height: 25,
                    ),
                    buildFileRow("CPU - HOME (LAPAZ)", " (16 mins)"),
                    const SizedBox(
                      height: 5,
                    ),
                    buildFileRowSub("₱100 - ₱170"),
                    const SizedBox(
                      height: 25,
                    ),
                    buildFileRow("FESTIVE - HOME (LAPAZ)", " (19 mins)"),
                    const SizedBox(
                      height: 5,
                    ),
                    buildFileRowSub("₱170 - ₱180"),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(
                              255, 235, 133, 0), // Outer border color
                          width: 4, // Outer border width
                        ),
                        borderRadius:
                            BorderRadius.circular(25), // Border radius
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.amber, // Inner border color
                            spreadRadius:
                                -1, // Negative value to create an inner border
                          ),
                        ],
                      ),
                      child: const Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                indent: 20,
                endIndent: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 80,
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                margin: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 5,
                ),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "You just arrived at your destination",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "More Info",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 0, 141, 59),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
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
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
              fontSize: 10,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(197, 0, 0, 0),
            ),
            children: [
              const TextSpan(
                text: "More Info ",
                style: TextStyle(
                  fontSize: 12,
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
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: place,
              ),
              TextSpan(
                text: time,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
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
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  const Color.fromARGB(255, 235, 133, 0), // Outer border color
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
