import 'package:flutter/material.dart';
import 'package:frontend/firebaseApi.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _subtitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _title,
              decoration: InputDecoration(hintText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _subtitle,
              decoration: InputDecoration(hintText: 'Description'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () async {
                if (_title.text.isEmpty || _subtitle.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Fill All Requirement'),
                        );
                      });
                } else {
                  setState(() {});
                  await FirebaseApi.instance
                      .PostApi(_title.text, _subtitle.text);
                  setState(() {});
                }
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: Size(double.infinity, 40)),
            ),
          )
        ],
      ),
    );
  }
}
