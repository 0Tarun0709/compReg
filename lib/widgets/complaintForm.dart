import 'package:flutter/material.dart';
import './ComplainReg.dart';


class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  final _complaintController = TextEditingController();

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  void _submitComplaint() {
    if (_formKey.currentState.validate()) {
      // Save the complaint in a database or send it to a server
      // Here we just display the confirmation page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ComplaintConfirmation(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _complaintController,
                decoration: InputDecoration(
                  labelText: 'Enter your complaint',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your complaint';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitComplaint,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
