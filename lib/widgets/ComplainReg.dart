import 'package:flutter/material.dart';

class ComplaintConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Registered'),
      ),
      body: Center(
        child: Text(
          'Your complaint has been registered',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
