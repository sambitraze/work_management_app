import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateFeedbackScreen extends StatefulWidget {
  const CreateFeedbackScreen({Key? key}) : super(key: key);

  @override
  _CreateFeedbackScreenState createState() => _CreateFeedbackScreenState();
}

class _CreateFeedbackScreenState extends State<CreateFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.check),
          backgroundColor: Color(0xFF314B8C),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 2.0,
                  margin: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(32.0),
                    ),
                  ),
                  color: Color(0xFF314B8C),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.create_new_folder,
                              color: Colors.white,
                              size: 32.0,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create',
                                  style: GoogleFonts.nunito(
                                    color: Color(0xFFE7E7E7),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'Feedback Form',
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Color(0xFFE7E7E7),
                              fontSize: 18.0,
                            ),
                            labelText: 'Title',
                            hintText: 'Enter feedback from title',
                            hintStyle: TextStyle(
                              color: Color(0xCBD4D4D4),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Color(0xFFE7E7E7),
                            ),
                            labelText: 'Description',
                            hintText: 'Enter description of feedback from',
                            hintStyle: TextStyle(
                              color: Color(0xCBD4D4D4),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  'Questions: ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '6',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              splashRadius: 20.0,
                              icon: Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FeedbackQuestionCard(
                  questionNumber: 1,
                ),
                FeedbackQuestionCard(
                  questionNumber: 2,
                ),
                FeedbackQuestionCard(
                  questionNumber: 3,
                ),
                FeedbackQuestionCard(
                  questionNumber: 4,
                ),
                FeedbackQuestionCard(
                  questionNumber: 5,
                ),
                FeedbackQuestionCard(
                  questionNumber: 6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeedbackQuestionCard extends StatelessWidget {
  const FeedbackQuestionCard({
    required this.questionNumber,
  });

  final int questionNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 20.0,
            ),
            child: Text(
              'Question $questionNumber',
              style: TextStyle(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Color(0xFF1A1A1A),
                ),
                labelText: 'Question',
                hintText: 'Enter the question here',
                hintStyle: TextStyle(
                  color: Color(0xCB424242),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
