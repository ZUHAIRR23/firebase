part of '../../pages.dart';

class HomeAttendancePage extends StatefulWidget {
  const HomeAttendancePage({super.key});

  @override
  State<HomeAttendancePage> createState() => _HomeAttendancePageState();
}

class _HomeAttendancePageState extends State<HomeAttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Attendance',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/attendance');
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    leading: const Icon(Icons.check_circle_outline,
                        size: 30, color: Colors.blue),
                    title: const Text('Check In',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.chevron_right, size: 24),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/leave');
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    leading: const Icon(Icons.calendar_today,
                        size: 30, color: Colors.green),
                    title: const Text('Leave Request',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.chevron_right, size: 24),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/history');
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    leading: const Icon(Icons.history,
                        size: 30, color: Colors.orange),
                    title: const Text('History',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.chevron_right, size: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
