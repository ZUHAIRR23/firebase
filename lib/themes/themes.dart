part of 'shared.dart';

final colorPrimary = '1D1C36FF'.toColor();
final colorWhite = 'FFFFFF'.toColor();

final imageLogo = AssetImage('assets/images/chill.jpg');
final imageGoogle = 'assets/icons/google.png';
final imageFacebook = 'assets/icons/facebook.png';

final welcomeText = 'Welcome back 🤚';
final registerText = 'Register';
final subWelcomeText = 'Have a nice day! \nLet\'s start your day with a smile and a cup of coffee ☕';
final subRegisterText = 'Create an account to continue';

final hintEmail = 'Email';
final hintPassword = 'Password';
final hintConfirmPassword = 'Confirm Password';
final hintForgotPassword = 'Forgot Password';
final hintSignIn = 'Sign In';
final hintSignUp = 'Sign Up';
final hintOtherSignInOptions = 'Other Sign In Options';
final hintOtherSignUpOptions = 'Other Sign Up Options';
final hintGoogle = 'Google';
final hintFacebook = 'Facebook';
final hintDoesntHaveAccount = 'Doesn\'t Have an Account?';
final hintAlreadyHaveAccount = 'Already Have an Account?';

TextStyle welcomeTextStyle = GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.black
);

TextStyle subWelcomeTextStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black54
);

TextStyle hintTextStyle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white
);