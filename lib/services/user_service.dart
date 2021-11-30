import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greencycle/model/Action.dart';
import 'package:greencycle/model/MyUser.dart';

class UserService {
  CollectionReference userRef = FirebaseFirestore.instance.collection(MyUser.collection_id);

  Future<void> create(MyUser user) async {
    final userDocument = userRef.doc(user.Id);
    userDocument.set(user.toMap());
  }

  Future<String> addUser(MyUser user) async {
    String id = "-1";
    await userRef.add(user.toMap())
        .then((value) => {id = value.id});
    return id;
  }

  Future<MyUser?> getCurrentUser() async{
    return await getUser(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<MyUser?> getUser(String id) async {
    MyUser user;
    DocumentSnapshot documentSnapshot = await userRef.doc(id).get();
    if (documentSnapshot.exists) {
      user = MyUser.fromSnapshot(documentSnapshot.id, documentSnapshot.data());
      return user;
    }
    return null;
  }

  Future<void> editUser(MyUser myUser) async{
    final userDocument = userRef.doc(myUser.Id);
    await userDocument.set(
        myUser.toMap(),
        SetOptions(merge: true)
    );
  }

  Future<void> addAction(String userId, Action action) async{
     userRef.doc(userId).collection('acciones').add(action.toMap());
  }

  Future<List<Action>> getUserActions(String userId) async{
    QuerySnapshot qs = await userRef.doc(userId).collection(Action.collection_id).get();
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