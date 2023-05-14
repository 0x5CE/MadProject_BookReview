import 'package:flutter/material.dart';

// import 'book.dart';
// import 'book_details_screen.dart';
import 'bookdetailscreen.dart';
import 'models/book.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BookCard extends StatelessWidget {
  final Book book;

  BookCard({@required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(
              title: book.title,
              author: book.author,
              reviews: book.reviews,
            ),
          ),
        );
      },
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          depth: 30,
          intensity: 3,
          lightSource: LightSource.topLeft,
          color: Colors.lightBlue[
              100], // Replace with your desired light background color
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display book details, such as title and author
              Text(
                book.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto', // Replace with your desired font
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                book.author,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontFamily: 'Roboto', // Replace with your desired font
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
