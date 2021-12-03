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

  Future<void> deleteGroup(String groupId) async{
    await groupRef.doc(groupId).delete();
  }

  ///get
  Future<List<Group>> getAll() async { //TODO:ver si esta bien
    QuerySnapshot querySnapshot = await groupRef.get();
    return querySnapshot.docs
        .map((value) => Group.fromSnapshot(value.data() as Map<String, dynamic>))
        .toList();
  }

  Future<Group?> getGroupById(String groupId) async{
    DocumentSnapshot ds = await groupRef.doc(groupId).get();
    if (ds.exists) {
      Group group = Group.fromSnapshot( ds.data() as Map<String, dynamic>);
      return group;
    }
    return null;
  }

  ///edits
  //se le pasa un Group con los datos que se quieren cambiar del grupo
  Future<void> editGroup(Group group, String groupId) async {
    final userDoc = groupRef.doc(groupId);
    await userDoc.set(group.toMap(), SetOptions(merge: true)
    );
  }

  ///members
  Future<void> addMembers(String groupId, List<String> membersList)async {
    final groupDoc = groupRef.doc(groupId);
    groupDoc.update({
      'members' : FieldValue.arrayUnion(membersList)
    });
  }

  Future<void> removeMembers(String groupId, List<String> membersList)async {
    final groupDoc = groupRef.doc(groupId);
    groupDoc.update({
      'members' : FieldValue.arrayRemove(membersList)
    });
  }

  Future<List<MyUser>> getMembersOfGroup(String id) async {
    return (getGroupById(id) as Group).members as List<MyUser>;
  }

  ///score
  //si se pasan un numero negativo se restan
  Future<void> addScore(String groupId, int score) async{
    final groupDoc = groupRef.doc(groupId);
    groupDoc.update({
      "score" : FieldValue.increment(score)
    });
  }

  //deja el escore del grupo en cero
  Future<void> scoreToZero(String groupId) async{
    final groupDoc = groupRef.doc(groupId);
    groupDoc.update({
      "score" : 0
    });
  }

  ///action
  Future<void> addAction(MyAction action, String groupId) async {
    final groupDoc = groupRef.doc(groupId);
    await groupDoc.set(action.toMap(), SetOptions(merge: true));
  }






}