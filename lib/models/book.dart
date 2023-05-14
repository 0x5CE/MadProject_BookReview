import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/review.dart';

class Book {
  final String title;
  final String author;
  final List<Review> reviews;

  Book({
    @required this.title,
    @required this.author,
    @required this.reviews,
  });
}
