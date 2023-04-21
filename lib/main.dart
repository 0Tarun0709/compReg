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
    if (_formKey.currentState.validate()) {
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
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 50),

                  // logo
                  Image.asset(
                    'assets/images/ccc.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _complaintController,
                    decoration: InputDecoration(
                        labelText: 'Enter your complaint',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your complaint';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 252, 250),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    onPressed: _submitComplaint,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ComplaintList(complaints: _complaints)),
                      );
                    },
                    child: Text("View Your Complaints"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComplaintList extends StatefulWidget {
  final List<String> complaints;

  ComplaintList({this.complaints});

  @override
  _ComplaintListState createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  void _deleteComplaint(int index) {
    setState(() {
      widget.complaints.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints',),
      ),
      body: widget.complaints.isEmpty
          ? Center(
              child: Image.asset('assets/images/waiting.png',
              width: 200,
              height: 200,
            )
            )
          : ListView.builder(
              itemCount: widget.complaints.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      margin: EdgeInsets.all(5),
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Complaint:',
                                  style: TextStyle(
                                    color: Color.fromARGB(205, 237, 61, 61),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _deleteComplaint(index),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.complaints[index],
                              style: TextStyle(fontSize: 33),
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
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

