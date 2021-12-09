import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser;

  bool isLoading = false;

  Map<String, dynamic> userData = Map();

  void signUp(
      {required Map<String, dynamic> userData,
      required String password,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: userData["email"],
      password: password,
    ).then((user) async {
      print("Aqui");
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

  void signIn() async {}

  void signOut() async {
    await _auth.signOut();

    userData.clear();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPassword() {}

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
}
