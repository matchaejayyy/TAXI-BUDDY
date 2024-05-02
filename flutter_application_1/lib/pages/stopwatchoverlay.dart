import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter_application_1/pages/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            TaxiBuddyHomePage(), // MapPage directly on the stack
            Positioned(
              bottom: 0,
              left: 0,
              right: 60,
              child: Opacity(
                opacity: 0.8, // Set the opacity value as needed
                child: StopwatchOverlay(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StopwatchOverlay extends StatefulWidget {
  const StopwatchOverlay({Key? key}) : super(key: key);

  @override
  _StopwatchOverlayState createState() => _StopwatchOverlayState();
}

class _StopwatchOverlayState extends State<StopwatchOverlay> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final bool _isHours = true;
  int _totalElapsedTime = 0;

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.7, // height
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snapshot) {
                final value = snapshot.data ?? 0;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: _isHours);
                return Text(
                  displayTime,
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),

            Text(
              "Total Time: ${(_totalElapsedTime / 60000).toStringAsFixed(2)} min",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Total Distance Traveled: ${totalDistance.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Fare Price: PHP ${(40 + ((_totalElapsedTime / 60000)*3) + totalDistance*8).toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  label: 'Start',
                  onPress: () {
                    _stopWatchTimer.onStartTimer();
                  },
                ),
                const SizedBox(
                  width: 10.0,
                ),
                CustomButton(
                  label: 'Stop',
                  onPress: () {
                    _stopWatchTimer.onStopTimer();
                    _totalElapsedTime = _stopWatchTimer.rawTime.value;
                    setState(() {});
                  },
                ),
              ],
            ),
            CustomButton(
              label: 'Reset',
              onPress: () {
                _stopWatchTimer.onResetTimer();
                _totalElapsedTime = 0;
                totalDistance = 0.0;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final Function onPress; // Made onPress required
  final String label;

  const CustomButton({
    this.color = Colors.blue,
    required this.onPress, // Made onPress required with closing parenthesis
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const StadiumBorder(),
      ),
      onPressed: () => onPress(), // Execute onPress when button is pressed
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

