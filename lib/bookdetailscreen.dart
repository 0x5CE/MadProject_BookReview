import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/book.dart';
import 'package:flutter_complete_guide/models/review.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addreviewmodalscreen.dart';

class BookDetailsScreen extends StatefulWidget {
  final String title;
  final String author;
  final List<Review> reviews;

  BookDetailsScreen({
    @required this.title,
    @required this.author,
    @required this.reviews,
    Book book,
  });

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${widget.title}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Author: ${widget.author}',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Reviews:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.reviews.length,
                itemBuilder: (context, index) {
                  final review = widget.reviews[index];
                  final reviewText = review.reviewText;
                  final reviewerName = review.reviewerName;

                  return ReviewCard(
                      reviewText: reviewText, reviewerName: reviewerName);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    // Request focus when the dialog is tapped
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: AddReviewModalScreen(
                    title: widget.title,
                    userEmail: 'user@example.com',
                    reviews: widget.reviews,
                  ),
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    @required this.reviewText,
    @required this.reviewerName,
  }) : super(key: key);

  final String reviewText;
  final String reviewerName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          depth: 10,
          intensity: 1,
          lightSource: LightSource.topLeft,
          color: Colors.red[400],
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"$reviewText"',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Reviewer: $reviewerName',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
