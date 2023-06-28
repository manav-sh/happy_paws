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
      Get.offAllNamed('/intro');
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAllNamed('/home');
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    // print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAllNamed('/intro');
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

        await auth.signInWithCredential(credential).then((user) {
          if (user.additionalUserInfo?.isNewUser == true) {
            Get.toNamed('/moreInfo');
          } else {
            Get.toNamed('/home');
          }
        }).catchError((onErr) {
          Get.snackbar(
              'Error', 'Some error occured while loggin in. Please try again.');
        });
      }
    } catch (e, t) {
      Get.snackbar("Error", e.toString(), duration: const Duration(seconds: 5));
      // ignore: avoid_print
      print(t);
    }
  }

  void register(String email, password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.toNamed('/moreInfo');
      });
    } on FirebaseAuthException catch (firebaseAuthException) {
      if (firebaseAuthException.code == "email-already-in-use") {
        Get.snackbar('Error', 'The user is already registered. Try again',
            snackPosition: SnackPosition.BOTTOM);
      } else if (firebaseAuthException.code == "invalid-email") {
        Get.snackbar('Error', 'The email you entered is invalid.');
      } else if (firebaseAuthException.code == "weak-password") {
        Get.snackbar('Error', 'Please enter a strong password');
      } else {
        Get.snackbar('Error', 'Some unknown error occured. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Some unknown error occured. Please try again..');
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (firebaseAuthException) {
      if (firebaseAuthException.code == "invalid-email") {
        Get.snackbar('Error', 'The user is already registered. Try again',
            snackPosition: SnackPosition.BOTTOM);
      } else if (firebaseAuthException.code == "wrong-password") {
        Get.snackbar('Error', 'The email you entered is invalid.');
      } else {
        Get.snackbar('Error', 'Some unknown error occured. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Some unknown error occured. Please try again..');
    }
  }

  void addAdditionalInfo(String name, String photoUrl, String number) async {
    try {
      await firebaseUser.value?.updateDisplayName(name);
      await firebaseUser.value?.updatePhotoURL(photoUrl);
    } catch (e) {
      Get.snackbar(
          'Error', 'Some error occured while registering. please try again.');
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
