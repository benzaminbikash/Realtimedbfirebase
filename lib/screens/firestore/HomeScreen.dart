import 'package:flutter/material.dart';
import 'package:frontend/firebaseApi.dart';
import 'package:frontend/model/noteModel.dart';
import 'package:frontend/screens/firestore/AddScreen.dart';
import 'package:frontend/screens/firestore/Answer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NodeModel> listNote = [];
  void getData() async {
    listNote = await FirebaseApi.instance.getApiData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddScreen()));
          },
          child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text('All Note'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
          itemCount: listNote.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnswerData(
                                nodeModel: listNote[index],
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 4),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(listNote[index].title.toString()),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
