import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/utils/utils.dart';

class PostAdd extends StatefulWidget {
  const PostAdd({super.key});

  @override
  State<PostAdd> createState() => _PostAddState();
}

class _PostAddState extends State<PostAdd> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final textMind = TextEditingController();
  // utils u=utils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Post')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: textMind,
            maxLines: 4,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What is in your mind?'),
          ),
        ),
        SizedBox(
          width: 120,
          child: ElevatedButton(
              onPressed: () {
                String id = DateTime.now().microsecondsSinceEpoch.toString();
                databaseRef
                    .child(id)
                    .set({'id': id, 'title': textMind.text.toString()}).then(
                        (value) {
                  utils().toastMessage('Added!');
                }).onError((error, stackTrace) {
                  debugPrint(error.toString());
                  utils().toastMessage(error.toString());
                });
              },
              child: Text('Add')),
        )
      ]),
    );
  }
}
