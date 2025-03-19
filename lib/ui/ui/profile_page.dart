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
  String? profileImage;
  File? imageFile;

  @override
  void initState() {
    _loadProfileData();
    _checkEmailVerified();
    super.initState();
  }

  void _checkEmailVerified() async {
    setState(() {
      isLoading = true;
    });

    User? user = _auth.currentUser;

    if (!user!.emailVerified) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email verification link has been sent'),
          backgroundColor: Colors.green,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  void _sendEmailVerification() async {
    setState(() {
      isLoading = true;
    });

    User? user = _auth.currentUser;
    await user!.sendEmailVerification();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email verification link has been sent'),
        backgroundColor: Colors.green,
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }

    if (imageFile != null) {
      _uploadImage(imageFile!);
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    setState(() {
      isLoading = true;
    });

    String userId = FirebaseAuth.instance.currentUser!.uid;
    Reference reference =
        FirebaseStorage.instance.ref().child('profile/$userId');

    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    await _auth.uploadProfileImage(imageUrl);

    setState(() {
      profileImage = imageUrl;
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile image updated success'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _updateProfile() async {
    setState(() {
      isLoading = true;
    });

    String firstName = firstNameController.text;
    String lastName = lastNameController.text;

    await _auth.updateProfile(firstName, lastName);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
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
    profileImage = userData['profile_image'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: imageFile != null
                              ? FileImage(imageFile!)
                              : profileImage != null
                                  ? NetworkImage(profileImage!)
                                  : const AssetImage('assets/images/chill.jpg')
                                      as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          elevation: 5,
                        ),
                        child: const Text('Simpan Profil'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/changePassword');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          elevation: 5,
                        ),
                        child: const Text('Ganti Kata Sandi'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  (FirebaseAuth.instance.currentUser!.emailVerified)
                      ? const Text(
                          'Email Verified',
                          style: TextStyle(color: Colors.green),
                        )
                      : ElevatedButton(
                          onPressed: _sendEmailVerification,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            elevation: 5,
                          ),
                          child: const Text('Kirim Verifikasi Email'),
                        ),
                ],
              ),
            ),
    );
  }
}
