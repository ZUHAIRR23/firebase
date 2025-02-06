part of '../pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isObscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController email2Controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseService firebaseService = FirebaseService();

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email and password cannot be empty',
          ),
        ),
      );
    } else {
      final user = await firebaseService.signIn(email, password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Email and password cannot be empty',
            ),
          ),
        );
      }
    }
  }

  void _forgotPassword() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Forgot Password',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: email2Controller,
                decoration: InputDecoration(
                  hintText: hintEmail,
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                final email = email2Controller.text.trim();

                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Email cannot be empty',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                try {
                  firebaseService.forgotPassword(email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Reset password link has been sent to your email',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  email2Controller.clear();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Email cannot be empty',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text(
                'send',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: imageLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                welcomeText,
                style: welcomeTextStyle,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                subWelcomeText,
                style: subWelcomeTextStyle,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: hintEmail,
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: hintPassword,
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
              child: GestureDetector(
                onTap: () {
                  _forgotPassword();
                },
                child: Text(
                  hintForgotPassword,
                  textAlign: TextAlign.end,
                  style: subWelcomeTextStyle,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  hintSignIn,
                  style: TextStyle(color: colorWhite),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                hintOtherSignInOptions,
                style: subWelcomeTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            // Icon Facebook & Google
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: AssetImage(imageGoogle),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        hintGoogle,
                        style: welcomeTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: AssetImage(imageFacebook),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        hintFacebook,
                        style: welcomeTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    hintDoesntHaveAccount,
                    style: subWelcomeTextStyle,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: Text(
                        hintSignUp,
                        style: subWelcomeTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
