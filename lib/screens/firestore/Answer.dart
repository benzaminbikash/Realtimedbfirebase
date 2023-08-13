
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/model/noteModel.dart';

class AnswerData extends StatefulWidget {
  final NodeModel? nodeModel;
  const AnswerData({super.key, required this.nodeModel});

  @override
  State<AnswerData> createState() => _AnswerDataState();
}

class _AnswerDataState extends State<AnswerData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Answer'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(widget.nodeModel!.subtitle.toString()),
      ),
    );
  }
}
