part of '../pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseService _auth = FirebaseService();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    _loadProfileData();
    super.initState();
  }

  void _updateProfile() async {
    setState(() {
      isLoading = true;
    });

    String firstName = firstNameController.text;
    String lastName = lastNameController.text;

    await _auth.updateProfile(firstName, lastName);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile update successfully'),
      ),
    );

    setState(() {
      isLoading = false;
    });
  }

  void _loadProfileData() async {
    User? user = _auth.currentUser;
    String userId = user!.uid;
    Map<String, dynamic> userData = await _auth.getUserData(userId);

    firstNameController.text = userData['first_name'];
    lastNameController.text = userData['last_name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              SizedBox(height: 10),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        _updateProfile();
                      },
                      child: Text('Save'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
