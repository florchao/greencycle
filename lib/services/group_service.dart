import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greencycle/model/Group.dart';

class GroupService{
  CollectionReference groupRef = FirebaseFirestore.instance.collection(Group.collection_id);

  Future<String> creat(Group group) async {
    String id = "-1";
    await groupRef.add(group.toMap())
        .then((value) => {id = value.id});
    return id;
  }



}