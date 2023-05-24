import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_paws/constants/auth.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();

    // Initialize the firebaseUser and GoogleSignIn Account.
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    // It binds the variable to the GetX. so whenever, auth.userChanges(), it updates the firebaseUser
    firebaseUser.bindStream(auth.userChanges());
    // The ever function is called whenever the firebaseUser is modified. and it calls the function provided in second paramter
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAllNamed('/login');
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAllNamed('/home');
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAllNamed('/login');
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAllNamed('/home');
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }
    } catch (e,t) {
      Get.snackbar("Error", e.toString(), duration: const Duration(seconds: 5));
      // ignore: avoid_print
      print(t);
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {
      Get.snackbar('Error', 'Some error occured while logging in');
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {
      Get.snackbar('Error', 'Some error occured while logging in');
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
