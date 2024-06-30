import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SmartCityAnnouncementPage extends StatefulWidget {
  @override
  _SmartCityAnnouncementPageState createState() =>
      _SmartCityAnnouncementPageState();
}

class _SmartCityAnnouncementPageState extends State<SmartCityAnnouncementPage> {
  String _announcementTitle = '';
  String _announcementDescription = '';
  String _category = '';
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  TextEditingController _detailsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> addAnnouncementData() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_startDate != null &&
          _endDate != null &&
          _startTime != null &&
          _endTime != null &&
          _detailsController.text.isNotEmpty) {
        try {
          DocumentReference docRef =
              await FirebaseFirestore.instance.collection("Announcements").add({
            "Title": _announcementTitle,
            "Description": _announcementDescription,
            "Category": _category,
            "Start Date": _startDate,
            "End Date": _endDate,
            "Start Time": _startTime!.format(context),
            "End Time": _endTime!.format(context),
            "Details": _detailsController.text
                .split(',')
                .map((e) => e.trim())
                .toList(),
          });

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Announcement uploaded successfully.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pop(); // Navigate back to the previous page
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Failed to upload announcement: $e'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Validation Error'),
              content: Text('Please fill out all the required fields.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  void _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  void _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement Upload'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Announcement Title *'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter announcement title';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _announcementTitle = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Announcement Description *'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter announcement description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _announcementDescription = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Category *'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter category';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    _startDate == null
                        ? 'Start Date *'
                        : 'Start Date *: ${DateFormat('yyyy-MM-dd').format(_startDate!)}',
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () {
                    _selectStartDate(context);
                  },
                ),
                ListTile(
                  title: Text(
                    _endDate == null
                        ? 'End Date *'
                        : 'End Date *: ${DateFormat('yyyy-MM-dd').format(_endDate!)}',
                  ),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () {
                    _selectEndDate(context);
                  },
                ),
                ListTile(
                  title: Text(
                    _startTime == null
                        ? 'Start Time *'
                        : 'Start Time *: ${_startTime!.format(context)}',
                  ),
                  trailing: Icon(Icons.access_time),
                  onTap: () {
                    _selectStartTime(context);
                  },
                ),
                ListTile(
                  title: Text(
                    _endTime == null
                        ? 'End Time *'
                        : 'End Time *: ${_endTime!.format(context)}',
                  ),
                  trailing: Icon(Icons.access_time),
                  onTap: () {
                    _selectEndTime(context);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Details *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter details';
                    }
                    return null;
                  },
                  controller: _detailsController,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: ElevatedButton(
          onPressed: addAnnouncementData,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 85, 1, 100)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text('Upload Announcement'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SmartCityAnnouncementPage(),
  ));
}
