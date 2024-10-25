import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompleteTrack extends StatelessWidget {
  final List<String> list;
  final String name;

  const CompleteTrack({super.key, required this.list, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Track'),
         // Change AppBar color to make it more lively
        // elevation: 4.0, // Add a shadow effect to AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding to the entire screen
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Name: $name",
                style: const TextStyle(
                  fontSize: 24, // Larger font size for emphasis
                  fontWeight: FontWeight.bold, // Bold for prominence
                  color: Colors.deepPurple, // Color match with AppBar
                ),
              ),
            ),
            const SizedBox(height: 10), // Spacing between title and list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 10), // Add vertical padding
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 10.0), // Spacing between items
                    elevation: 3.0, // Slight elevation to give depth
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Rounded corners for items
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(
                          15.0), // Padding inside each item
                      tileColor: Colors.white, // White background for clarity
                      title: Text(
                        list[index],
                        style: const TextStyle(
                          fontSize:
                              18, // Increase font size for better readability
                          color: Colors.black87, // Dark text for good contrast
                          fontWeight: FontWeight.w500, // Medium boldness
                        ),
                      ),
                      leading: const Icon(
                        Icons
                            .check_circle_outline, // Icon for better visualization
                        color: Colors.green, // Positive, friendly color
                        size: 28,
                      ),
                      trailing: const Icon(
                        Icons
                            .arrow_forward_ios, // Trailing icon for navigation feel
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
