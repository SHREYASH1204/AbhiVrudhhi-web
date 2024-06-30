// upload_event_page.dart
import 'package:flutter/material.dart';
import 'smart_city_announcement_page.dart'; // Ensure you have this import for the SmartCityAnnouncementPage

class UploadEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Event'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SmartCityAnnouncementPage(),
              ),
            );
          },
          child: Text('Upload Event'),
        ),
      ),
    );
  }
}
