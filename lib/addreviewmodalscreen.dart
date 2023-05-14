import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/review.dart';

class AddReviewModalScreen extends StatefulWidget {
  final String title;
  final String userEmail;
  List<Review> reviews = [];

  AddReviewModalScreen({
    @required this.title,
    @required this.userEmail,
    @required this.reviews,
  });

  @override
  _AddReviewModalScreenState createState() => _AddReviewModalScreenState();
}

class _AddReviewModalScreenState extends State<AddReviewModalScreen> {
  TextEditingController reviewController = TextEditingController();
  String reviewText = '';

  void addReviewToBookCollection() {
    String bookTitle = widget.title;
    User user = FirebaseAuth.instance.currentUser;
    String reviewerName = user.email;
    String reviewText = reviewController.text;

    print("revierName: ");
    print(reviewerName);
    // Create a new review map
    Map<String, dynamic> review = {
      'reviewText': reviewText,
      'reviewerName': reviewerName,
    };

    // Update the book collection with the new review
    FirebaseFirestore.instance
        .collection('books')
        .where('title', isEqualTo: bookTitle)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document (assuming there's only one book with the same title)
        DocumentSnapshot bookDocument = querySnapshot.docs[0];

        // Get the existing reviews
        List<dynamic> existingReviews =
            (bookDocument.data() as Map<String, dynamic>)['reviews'];

        // Add the new review to the existing reviews
        existingReviews.add(review);

        // Update the document with the updated reviews
        bookDocument.reference.update({
          'reviews': existingReviews,
        }).then((value) {
          // Review added successfully

          widget.reviews.add(Review(
            reviewText: reviewText,
            reviewerName: reviewerName,
          ));

          print('Review added successfully');
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Review added successfully'),
            ),
          );
        }).catchError((error) {
          // Failed to add review
          print('Failed to add review: $error');
        });
      } else {
        // Book not found
        print('Book not found');
      }
    }).catchError((error) {
      // Error retrieving book
      print('Error retrieving book: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Change to your desired background color
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Review',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: reviewController,
              onChanged: (value) {
                setState(() {
                  // Remove the reviewText assignment
                });
              },
              // Rest of the TextField properties...
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addReviewToBookCollection,
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
