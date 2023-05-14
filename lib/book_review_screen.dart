import 'package:flutter/material.dart';

import 'bookdetailscreen.dart';
import 'models/book.dart';
import 'bookcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'models/review.dart';

class BookReviewScreen extends StatefulWidget {
  @override
  _BookReviewScreenState createState() => _BookReviewScreenState();
}

class _BookReviewScreenState extends State<BookReviewScreen> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    initializeBooks();
  }

  Future<void> initializeBooks() async {
    if (books.isEmpty) {
      await getBooksFromFirestore();
    }
  }

  Future<void> getBooksFromFirestore() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('books').get();

      List<Book> retrievedBooks = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        String title = data['title'];
        String author = data['author'];
        List<dynamic> reviewsData = data['reviews'];

        List<Review> reviews = reviewsData.map((reviewData) {
          String reviewText = reviewData['reviewText'] as String;
          String reviewerName = reviewData['reviewerName'] as String;
          return Review(reviewText: reviewText, reviewerName: reviewerName);
        }).toList();

        Book book = Book(title: title, author: author, reviews: reviews);
        retrievedBooks.add(book);
      });

      setState(() {
        books = retrievedBooks; // Assign retrieved books to the books variable
      });
    } catch (error) {
      print('Failed to retrieve books: $error');
    }
  }

  void createBookCollection() {
    FirebaseFirestore.instance
        .collection('books')
        .add({
          'title': 'Treasure Island',
          'author': 'Robert Louis Stevenson',
          'reviews': [
            {
              'reviewText': 'Exciting adventure story!',
              'reviewerName': 'AdventureSeeker',
            },
            {
              'reviewText': 'A classic that never gets old.',
              'reviewerName': 'LiteratureLover',
            },
          ],
        })
        .then((value) => print('Book collection created'))
        .catchError(
            (error) => print('Failed to create book collection: $error'));

    FirebaseFirestore.instance
        .collection('books')
        .add({
          'title': 'To Kill a Mockingbird',
          'author': 'Harper Lee',
          'reviews': [
            {
              'reviewText': 'A classic that tackles important themes.',
              'reviewerName': 'LiteratureLover',
            },
            {
              'reviewText': 'A must-read for everyone.',
              'reviewerName': 'Bookworm123',
            },
          ],
        })
        .then((value) => print('Book collection created'))
        .catchError(
            (error) => print('Failed to create book collection: $error'));

    FirebaseFirestore.instance
        .collection('books')
        .add({
          'title': '1984',
          'author': 'George Orwell',
          'reviews': [
            {
              'reviewText': 'A dystopian masterpiece!',
              'reviewerName': 'OrwellFanatic',
            },
            {
              'reviewText': 'Thought-provoking and chilling.',
              'reviewerName': 'BigBrotherWatcher',
            },
          ],
        })
        .then((value) => print('Book collection created'))
        .catchError(
            (error) => print('Failed to create book collection: $error'));

    FirebaseFirestore.instance
        .collection('books')
        .add({
          'title': 'The Great Gatsby',
          'author': 'F. Scott Fitzgerald',
          'reviews': [
            {
              'reviewText': 'Captivating and beautifully written.',
              'reviewerName': 'GatsbyObsessed',
            },
            {
              'reviewText': 'A timeless classic.',
              'reviewerName': 'LiteraryEnthusiast',
            },
          ],
        })
        .then((value) => print('Book collection created'))
        .catchError(
            (error) => print('Failed to create book collection: $error'));

    FirebaseFirestore.instance
        .collection('books')
        .add({
          'title': 'Harry Potter and the Sorcerer\'s Stone',
          'author': 'J.K. Rowling',
          'reviews': [
            {
              'reviewText': 'Magical and enchanting!',
              'reviewerName': 'Potterhead1',
            },
            {
              'reviewText': 'A captivating start to the series.',
              'reviewerName': 'WizardingWorldFan',
            },
          ],
        })
        .then((value) => print('Book collection created'))
        .catchError(
            (error) => print('Failed to create book collection: $error'));

    FirebaseFirestore.instance
        .collection('books')
        .add({
          'title': 'Pride and Prejudice',
          'author': 'Jane Austen',
          'reviews': [
            {
              'reviewText': 'A classic romance novel.',
              'reviewerName': 'RomanceReader',
            },
            {
              'reviewText': 'Engaging characters and witty dialogues.',
              'reviewerName': 'LiteraryFanatic',
            },
          ],
        })
        .then((value) => print('Book collection created'))
        .catchError(
            (error) => print('Failed to create book collection: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              title: NeumorphicText(
                'Reviews',
                style: NeumorphicStyle(
                    depth: 0, color: Colors.black, intensity: 1),
                textStyle: NeumorphicTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'YourCustomFont',
                ),
              ),
              centerTitle: true,
            ),
            brightness: Brightness.dark,
            elevation: 0,
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height * 0.7),
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final book = books[index];
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
                    child: BookCard(
                      book: book,
                    ),
                  );
                },
                childCount: books.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
