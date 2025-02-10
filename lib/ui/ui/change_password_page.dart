part of '../pages.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final FirebaseService _auth = FirebaseService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isObscureText = true;
  bool isLoading = false;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _changePassword() async {
    setState(() {
      isLoading = true;
    });

    String currentPassword = currentPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // check if the field is empty
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackBar("Please fill all the fields");
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (newPassword != confirmPassword) {
      _showSnackBar("New password and confirm password is not the same");
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        _showSnackBar('User not found');
        setState(() {
          isLoading = false;
        });
        return;
      }

      // re-authenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // old password cannot be the same as new password
      if (currentPassword == newPassword) {
        _showSnackBar('Old password cannot be the same as new password');
        setState(() {
          isLoading = false;
        });
        return;
      }

      await _auth.changePassword(newPassword);

      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      await _auth.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password changed successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseAuthException catch (e) {
      _showSnackBar(e.message.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: currentPasswordController,
                decoration: InputDecoration(
                  hintText: hintCurrentPassword,
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    icon: isObscureText
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                ),
                obscureText: isObscureText ? true : false,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  hintText: hintNewPassword,
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    icon: isObscureText
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                ),
                obscureText: isObscureText ? true : false,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: hintConfirmPassword,
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    icon: isObscureText
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                ),
                obscureText: isObscureText ? true : false,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _changePassword();
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
