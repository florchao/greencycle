import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/model/MyAction.dart';
import 'package:greencycle/model/MyUser.dart';

class GroupService{
  CollectionReference groupRef = FirebaseFirestore.instance.collection(Group.collection_id);

  Future<String> addGroup(Group group)async{
    String id = '-1';
    await groupRef.add(group.toMap()).then((value) => {id = value.id});
    return id;
  }

  Future<void> deleteGroup(String groupId){
    //Todo: felu
  }

  Future<void> addAction(MyAction action, String groupId) async {
    final groupDoc = groupRef.doc(groupId);
    await groupDoc.set(action.toMap(), SetOptions(merge: true));
  }

  Future<List<Group>> get() async {
    QuerySnapshot querySnapshot = await groupRef.get();
    return querySnapshot.docs
        .map((value) => Group.fromSnapshot(value.id, value.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<MyUser>> getMembers(String Id) async {
    //Todo:

  }

  Future<Group> getGroupById(String Id) async {
      //TODO:
  }





}