import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/screens/PostAdd.dart';
import 'package:frontend/screens/login.dart';
import 'package:frontend/utils/utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchData = TextEditingController();
  final editText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchData,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Search Here'),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                if (searchData.text.isEmpty) {
                  return ListTile(
                    subtitle: Text(snapshot.child('id').value.toString()),
                    title: Text(snapshot.child('title').value.toString()),
                    trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      myDialog(
                                          title,
                                          snapshot
                                              .child('id')
                                              .value
                                              .toString());
                                    },
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                  )),
                              PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      ref
                                          .child(snapshot
                                              .child('id')
                                              .value
                                              .toString())
                                          .remove();
                                    },
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete'),
                                  ))
                            ]),
                  );
                } else if (title
                    .toLowerCase()
                    .toString()
                    .contains(searchData.text.toLowerCase())) {
                  return ListTile(
                    subtitle: Text(snapshot.child('id').value.toString()),
                    title: Text(snapshot.child('title').value.toString()),
                  );
                } else {
                  return Container(); // Add return statement
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PostAdd();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> myDialog(String title, String id) async {
    editText.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Update',
              ),
            ),
            content: Container(
              child: TextField(
                controller: editText,
                decoration: InputDecoration(hintText: 'edit...'),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update(
                        {'title': editText.text.toLowerCase()}).then((value) {
                      utils().toastMessage("Updated!");
                    }).onError((error, stackTrace) {
                      utils().toastMessage(error.toString());
                    });
                  },
                  child: Text('Update'))
            ],
          );
        });
  }
}
