part of '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseService _auth = FirebaseService();

  void _signOut() async {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              welcomeText,
              style: welcomeTextStyle,
            ),
            Text(
              'Email Saya: ${_auth.currentUser.email}',
              style: subWelcomeTextStyle.copyWith(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () {
                _signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
