import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersBloc extends BlocBase {
  final _ordersController = BehaviorSubject<List>();

  // Map {uid: dados do usuario}
  List<DocumentSnapshot> _orders = [];

  final _firestore = FirebaseFirestore.instance;

  Stream<List> get outOrders => _ordersController.stream;

  OrdersBloc() {
    // Add a listener para observar mudanças nos usuários
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection('orders').snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        String oid = change.doc.id;
        if (change.type == DocumentChangeType.added) {
          _orders.add(change.doc);
        } else if (change.type == DocumentChangeType.modified) {
          _orders.removeWhere((order) => order.id == oid);
          _orders.add(change.doc);
        } else if (change.type == DocumentChangeType.removed) {
          _orders.removeWhere((order) => order.id == oid);
        }
      });
      _ordersController.add(_orders);
    });
  }

  void forwardStatus(DocumentSnapshot order) {
    _firestore
        .collection('orders')
        .doc(order.id)
        .update({"status": order.get('status') + 1});
  }

  void backwardStatus(DocumentSnapshot order) {
    _firestore
        .collection('orders')
        .doc(order.id)
        .update({"status": order.get('status') - 1});
  }

  void deleteOrder(String oid, String userId) {
    _firestore.collection('orders').doc(oid).delete();
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(oid)
        .delete();
  }

  @override
  void dispose() {
    _ordersController.close();
    super.dispose();
  }
}
