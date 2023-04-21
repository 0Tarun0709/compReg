import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint Box',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: ComplaintForm(),
      
    );
  }
}

class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  final _complaintController = TextEditingController();
  List<String> _complaints = [];

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {
      // Add the complaint to the list
      _complaints.add(_complaintController.text);

      // Clear the text field
      _complaintController.clear();

      // Show a dialog to confirm the complaint submission
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Complaint submitted'),
          content: Text('Your complaint has been registered.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Dismiss the dialog
                Navigator.of(context).pop();

                // Navigate to the view complaints page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ComplaintList(complaints: _complaints),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Box'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _complaintController,
                decoration: InputDecoration(
                  labelText: 'Enter your complaint',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your complaint';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: _submitComplaint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComplaintList extends StatelessWidget {
  final List<String> complaints;

  ComplaintList({required this.complaints});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints'),
      ),
      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          /*return ListTile(
            title: Text(complaints[index]),
          );*/
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    margin: EdgeInsets.all(5),
                    elevation: 10,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            complaints[index],
                            style: TextStyle(fontSize: 50),
                          ),
                          
                          TextButton(
                            child: Text('Status'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Complaint Pending'),
                                  content: Text(
                                      'Hold on, Your Complaint will be resolved soon'),
                                  
                                ),
                              );
                              // Dismiss the dialog
                            },
                          )
                        ])),
              ]);
        },
      ),
    );
  }
}
