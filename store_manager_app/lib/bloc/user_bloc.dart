import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserBloc extends BlocBase {
  final _userController = BehaviorSubject<List>();

  // Map {uid: dados do usuario}
  Map<String, Map<String, dynamic>> _users = {};

  final _firestore = FirebaseFirestore.instance;

  Stream<List> get outUsers => _userController.stream;

  UserBloc() {
    // Add a listener para observar mudanças nos usuários
    _addUsersListener();
  }

  void _addUsersListener() {
    //Stream da coleção de users
    _firestore.collection('users').snapshots().listen((snapshot) {
      // Para cada alteração, faça ...
      snapshot.docChanges.forEach((change) {
        String uid = change.doc.id;

        if (change.type == DocumentChangeType.added) {
          _users[uid] = change.doc.data()!;
          _subscribeToOrders(uid);

        } else if (change.type == DocumentChangeType.modified) {
          _users[uid]!.addAll(change.doc.data()!);
          _userController.add(_users.values.toList());

        } else if (change.type == DocumentChangeType.removed) {
          _users.remove(uid);
          _unsubscribeToOrders(uid);
          _userController.add(_users.values.toList());

        }
      });
    });
  }

  void _subscribeToOrders(String uid) {
    // Listener para as informações dos pedidos
    // Add um novo campo, para que seja possivel cancelar o subscription
    _users[uid]!["subscriptions"] = _firestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .snapshots()
        .listen((orders) async {
      int numOrders = orders.docs.length;
      double moneySpended = 0;

      for (DocumentSnapshot doc in orders.docs) {
        DocumentSnapshot order =
            await _firestore.collection('orders').doc(doc.id).get();

        if (order.data() == null) continue;
        moneySpended += order.get('totalPrice');
        _users[uid]!.addAll({"moneySpended": moneySpended, "orders": numOrders});
      }
      // Pega apenas a part de values do Map e transforma em uma lista;
      _userController.add(_users.values.toList());
    });
  }

  // Cancela a observação para os pedidos do usuario
  void _unsubscribeToOrders(String uid) {
    _users[uid]!["subscriptions"].cancel();
  }

  @override
  void dispose() {
    _userController.close();
    super.dispose();
  }
}
