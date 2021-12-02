import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyAction.dart';
import 'package:greencycle/model/MyUser.dart';
import 'package:greencycle/services/group_service.dart';

class UserService {
  CollectionReference userRef = FirebaseFirestore.instance.collection(
      MyUser.collection_id);

  GroupService groupService = new GroupService();

  Future<void> create(MyUser user) async {
    final userDocument = userRef.doc(user.Id);
    userDocument.set(user.toMap());
  }

  //devulve un objeto myUser con toda la info del usurario actual
  Future<MyUser?> getCurrentUser() async{
    return await getUser(getCurrentUserId());
  }

  String getCurrentUserId(){
    return FirebaseAuth.instance.currentUser!.uid;
  }

  //devulve un MyUser con toda la informacion del user con el id pasado
  Future<MyUser?> getUser(String id) async {
    MyUser user;
    DocumentSnapshot documentSnapshot = await userRef.doc(id).get();
    if (documentSnapshot.exists) {
      user = MyUser.fromSnapshot(documentSnapshot.id, documentSnapshot.data() as Map<String, dynamic>);
      return user;
    }
    return null;
  }

  // Future<List<MyUser>> getAllUser(String email, int max) async {
  //   userRef.
  // }


  //se le pasa un MyUser con los datos que se quieren cambiar del usuario acutal
  //(no hace falta poner nada en la variable id)
  Future<void> editCurrentUser(MyUser user)async {
    user.Id = (getCurrentUser() as MyUser).Id; //no se si esta bien
    editUser(user);
  }

  //se le pasa un MyUser con los datos que se quieren cambiar de un user
  //IMPORTANTE!! en la variable user se pone el token del user a editar
  Future<void> editUser(MyUser myUser) async {
    final userDocument = userRef.doc(myUser.Id);
    await userDocument.set(myUser.toMap(), SetOptions(merge: true)
    );
  }

  Future<void> addAction(MyAction action) async {
    addScore(action.score);

    //gargar accion a todos los grupos del usuario
    userRef.doc(getCurrentUserId()).collection(MyAction.collection_id).add(action.toMap());
  }

  Future<void> addScoreToUser(int score, String userId)async {
    final userDoc = userRef.doc(userId);
    userDoc.update({
      "score" : FieldValue.increment(1)
    });
  }


  Future<void> addScore(int score)async {
    final userDoc = userRef.doc(getCurrentUserId());
    userDoc.update({
      "score" : FieldValue.increment(score)
    });
  }

  Future<List<MyAction>> getUserAction()async{
    QuerySnapshot qs = await userRef.doc(getCurrentUserId()).collection(MyAction.collection_id).get();
    return qs.docs
        .map((value) => MyAction.fromSnapshot(value.id, value.data() as Map<String, dynamic>))
        .toList();
  }

  //metodos para grupos
  Future<String> addGroup(Group groupId) async{
    String id = await groupService.addGroup(groupId);
    if(id == "-1"){
      return id;
    }
    final userDoc = userRef.doc(getCurrentUserId());
    userDoc.update({
      "groups" : FieldValue.arrayUnion([id])
    });
    return id;
  }

  Future<void> deleteGroup(String groupId)async{
    groupService.deleteGroup(groupId);
    final userDoc = userRef.doc(getCurrentUserId());
    userDoc.update({
      "groups" : FieldValue.arrayRemove([groupId])
    });
  }

  Future<List<String>> getUserGroups()async{
    MyUser? user = await getCurrentUser();
    return user!.groups;
  }


  // Future<void> _getUserName() async {
  //   Firestore.instance
  //       .collection('Users')
  //       .document((await FirebaseAuth.instance.currentUser()).uid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       _userName = value.data['UserName'].toString();
  //     });
  //   });
  // }
