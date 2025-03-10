part of '../../../pages.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History attendance"),
      ),
      body: Center(
        child: Text("Ini adalah body"),
      ),
    );
  }
}

class DataServiceHistoryAttendance {
  final auth = FirebaseAuth.instance;

  // get id attendance users
  CollectionReference getUserAttendance() {
    final String? userId = auth.currentUser!.uid;
    if (userId == null) {
      throw Exception("User not logged in!");
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('attendance');
  }

  // get data attendance user
  Stream<QuerySnapshot> getAttendanceStream() {
    return getUserAttendance()
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
