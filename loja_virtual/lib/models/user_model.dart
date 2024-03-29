import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser;

  bool isLoading = false;

  Map<String, dynamic> userData = Map();

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);

  void signUp(
      {required Map<String, dynamic> userData,
      required String password,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
      email: userData["email"],
      password: password,
    )
        .then((user) async {
      firebaseUser = user.user!;
      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {required String email,
      required String password,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async{
      firebaseUser = user.user!;

      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userData.clear();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPassword({required email}) {
    _auth.sendPasswordResetEmail(email: email);
  }

  // Verifica se está logado
  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .set(userData);
  }

  Future<void> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      if (userData["name"] == null){
          DocumentSnapshot docUser = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser!.uid)
          .get();
          userData = docUser.data() as Map<String, dynamic>;
      }
    }
  }
}
