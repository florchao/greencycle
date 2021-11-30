import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greencycle/model/Action.dart';
import 'package:greencycle/model/User.dart';

class Users {
  CollectionReference usersRef = FirebaseFirestore.instance.collection(User.collection_id);

  Future<void> create(User user) async {
    await usersRef.add(user.toMap());
  }

  Future<User?> getUser(String id) async {
    User user;
    DocumentSnapshot documentSnapshot = await usersRef.doc(id).get();
    if (documentSnapshot.exists) {
      user = User.fromSnapshot(documentSnapshot.id, documentSnapshot.data());
      return user;
    }
    return null;
  }

  Future<void> addAction(String userId, Action action) async{
     usersRef.doc(userId).collection('acciones').add(action.toMap());
  }

  Future<List<Action>> getUserActions(String userId) async{
    QuerySnapshot qs = await usersRef.doc(userId).collection(Action.collection_id).get();
      return qs.docs.map((ds) => Action.fromSnapshot(ds.data())).toList();
    }
  }



  // Future<List<User>> get() async {
  //   QuerySnapshot querySnapshot = await usersRef.get();
  //   return querySnapshot.docs
  //       .map((ds) => Usuario.fromSnapshot(ds.id, ds.data()))
  //       .toList();
  // }

  // Stream<List<User>> getByName(String name) {
  //   return usersRef.where('name', isEqualTo: name).snapshots().map(
  //           (e) => e.docs
  //           .map((ds) => Usuario.fromSnapshot(ds.id, ds.data()))
  //           .toList());
  // }
}

mixin  {
}