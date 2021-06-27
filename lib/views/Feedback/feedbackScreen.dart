import 'package:flutter/material.dart';
import 'package:work_management_app/views/Feedback/createFeedbackFormScr.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF314B8C),
              child: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateFeedbackScreen(),
                  ),
                );
              },
            ),
          );
  }
}
