import 'package:flutter/material.dart';
import 'book_review_screen.dart';
import 'explorescreen.dart';
import 'favoritesscreen.dart';
import 'loginscreen.dart'; // Import the login screen file
import 'package:firebase_core/firebase_core.dart';
import 'authscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BookReviewApp());
}

class BookReviewApp extends StatefulWidget {
  @override
  _BookReviewAppState createState() => _BookReviewAppState();
}

class _BookReviewAppState extends State<BookReviewApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    // Implement your login check logic here
    // Example:
    // bool isLoggedIn = await isLoggedInFunction();

    // If the user is logged in
    // setState(() {
    //   _isLoggedIn = isLoggedIn;
    // });

    // If the user is not logged in
    // setState(() {
    //   _isLoggedIn = isLoggedIn;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      title: 'ChapterChats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isLoggedIn ? MainAppScreen() : AuthScreen(),
    );
  }
}

class MainAppScreen extends StatefulWidget {
  @override
  final bool isLoggedIn;

  const MainAppScreen({Key key, this.isLoggedIn})
      : super(key: key); // Add this line

  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    BookReviewScreen(),
    ExploreScreen(),
    FavoriteScreen(),
  ];

  // _MainAppScreenState(this.isLoggedIn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'ChapterChats',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(82, 137, 147, 1.0),
                Color.fromRGBO(173, 216, 230, 1.0),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        elevation: 8,
        toolbarHeight: 80,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'Reviews',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
