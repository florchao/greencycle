import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greencycle/model/Group.dart';
import 'package:greencycle/services/user_service.dart';

class GroupService{

  CollectionReference groupRef = FirebaseFirestore.instance.collection(Group.collection_id);

  Future<String> create(Group group)async{
    String id = '-1';
    await groupRef.add(group.toMap()).then((value) => {id = value.id});
    return id;
  }

  Future<void> deleteGroup(String groupId) async{
    await groupRef.doc(groupId).delete();
  }

  ///get
  Future<List<Group>> getAll(int size) async {
    QuerySnapshot querySnapshot = await groupRef.limit(size).get();
    return querySnapshot.docs
        .map((value) => Group.fromSnapshot(value.id, value.data() as Map<String, dynamic>))
        .toList();
  }

  Future<Group?> getGroupById(String groupId) async{
    Group group;
    DocumentSnapshot ds = await groupRef.doc(groupId).get();
    if (ds.exists) {
      group = Group.fromSnapshot( ds.id, ds.data() as Map<String, dynamic>);
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
  Future<void> addMember(String groupId, String memberId)async {
    UserService userService = new UserService();
    final groupDoc = groupRef.doc(groupId);
    groupDoc.set({
      'members' : {
        memberId : 0
      }
    }, SetOptions(merge: true) );

    userService.addUserToGroup(groupId, memberId);
  }

  Future<void> removeMembers(String groupId, String memberId)async {
    final groupDoc = groupRef.doc(groupId);
    groupDoc.set({
      'members' : {
        memberId : FieldValue.delete()
      }
    }, SetOptions(merge: true));
  }

  // Future<List<MyUser>> getMembersOfGroup(String id) async {
  //   return (getGroupById(id) as Group).members as List<MyUser>;
  // }

  ///score
  //NO USAR!!!
  //si se pasan un numero negativo se restan
  Future<void> addScore(String groupId, int score, String memberId) async{
    final groupDoc = groupRef.doc(groupId);
    int _auxScore = 0;
    await groupDoc.get().then((value) => _auxScore = value.get('members')[memberId]);
    _auxScore += score;
    groupDoc.update({
      "score" : FieldValue.increment(score),
      "members" : {
        memberId : _auxScore
      }
    });
  }

  ///action
  //NO USAR!!!
  Future<void> addAction(String groupId, String actionId) async{
    final groupDoc = groupRef.doc(groupId);
    await groupDoc.update({
      'actions': FieldValue.arrayUnion([actionId])
    });
  }

  Future<void> removeAction(String groupId, String actionId) async{
    final groupDoc = groupRef.doc(groupId);
    await groupDoc.update({
      'actions': FieldValue.arrayRemove([actionId])
    });
  }








}