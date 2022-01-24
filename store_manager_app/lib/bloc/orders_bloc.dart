import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum SortCriteria { DELIVERED_FIRST, DELIVERED_LAST }

class OrdersBloc extends BlocBase {
  final _ordersController = BehaviorSubject<List>();

  // Map {uid: dados do usuario}
  List<DocumentSnapshot> _orders = [];

  final _firestore = FirebaseFirestore.instance;

  Stream<List> get outOrders => _ordersController.stream;

  SortCriteria _criteria = SortCriteria.DELIVERED_FIRST;
  OrdersBloc() {
    // Add a listener para observar mudanças nos usuários
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection('orders').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        String oid = change.doc.id;
        if (change.type == DocumentChangeType.added) {
          _orders.add(change.doc);
        } else if (change.type == DocumentChangeType.modified) {
          _orders.removeWhere((order) => order.id == oid);
          _orders.add(change.doc);
        } else if (change.type == DocumentChangeType.removed) {
          _orders.removeWhere((order) => order.id == oid);
        }
      }
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
    // _ordersController.add(_orders);
  }

  void setSortCriteria(SortCriteria criteria) {
    _criteria = criteria;

    switch (_criteria) {
      case SortCriteria.DELIVERED_FIRST:
        _orders.sort((a, b) {
          int statusA = a.get('status');
          int statusB = b.get('status');

          if (statusA > statusB) {
            return -1;
          } else if (statusA < statusB) {
            return 1;
          } else {
            return 0;
          }
        });
        break;
      case SortCriteria.DELIVERED_LAST:
        _orders.sort((a, b) {
          int statusA = a.get('status');
          int statusB = b.get('status');

          if (statusA < statusB) {
            return -1;
          } else if (statusA > statusB) {
            return 1;
          } else {
            return 0;
          }
        });
        break;
      default:
        break;
    }

    _ordersController.add(_orders);
  }

  @override
  void dispose() {
    _ordersController.close();
    super.dispose();
  }
}
