import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  ///get
  String getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  //devuelve un objeto myUser con toda la info del usuario actual
  Future<MyUser?> getCurrentUser() async {
    return await getUser(getCurrentUserId());
  }

  //devuelve un MyUser con toda la informacion del usuario con el id pasado
  Future<MyUser?> getUser(String id) async {
    MyUser user;
    DocumentSnapshot documentSnapshot = await userRef.doc(id).get();
    if (documentSnapshot.exists) {
      user = MyUser.fromSnapshot(
          documentSnapshot.id, documentSnapshot.data() as Map<String, dynamic>);
      return user;
    }
    return null;
  }

  Future<List<MyUser>> getAllUser(String email,int size) async {
    QuerySnapshot qs = await userRef.where('email', isGreaterThanOrEqualTo: email)
        .orderBy('email').limit(size)
        .get();
    return qs.docs.map((value) => MyUser.fromSnapshot(
        value.id, value.data() as Map<String, dynamic>)).toList();
  }

  ///edit
  //se le pasa un MyUser con los datos que se quieren cambiar del usuario acutal
  //no se puede editar los valores id, score y groups de un usuario
  Future<void> editCurrentUser(MyUser user) async {
    MyUser currentUser = await getCurrentUser() as MyUser;
    user.Id = currentUser.Id;
    user.groups = currentUser.groups;
    user.score = currentUser.score;
    if(user.name == ""){user.name = currentUser.name;}
    if(user.last_name == ""){user.last_name = currentUser.last_name;}
    if(user.icon_url == ""){user.icon_url = currentUser.icon_url;}
    if(user.email == ""){user.email = currentUser.email;}
    await editUser(user);
  }

  //se le pasa un MyUser con los datos que se quieren cambiar del usuario y
  //en la variable id de myUser se poner el id del usuario que se quiere editar
  //IMPORTANTE: no usar
  Future<void> editUser(MyUser myUser) async {
    final userDocument = userRef.doc(myUser.Id);
    await userDocument.set(myUser.toMap(), SetOptions(merge: true)
    );
  }

  ///score
  //agrega al usuario actual y  a todos los grupos que participa
  //si score es un numero negativo entonce se resta
  Future<void> addScoreToUser(int score, String userId) async {
    final userDoc = userRef.doc(userId);
    userDoc.update({
      "score": FieldValue.increment(score)
    });

    List<String> groups;
    userDoc.get().then((data) => {
      groups = List.from(data.get('groups')),
      groups.forEach((element) {
        groupService.addScore(element, score, data.id);
      }),
    });
  }

  Future<void> addScore(int score) async {
    addScoreToUser(score, getCurrentUserId());
  }

  //deja el escore del grupo en cero
  Future<void> scoreToZero(String userId) async{
    final userDoc = userRef.doc(userId);
    userDoc.update({
      "score" : 0
    });
  }

  Future<void> scoreToZeroCurrentUser() async{
    final userDoc = userRef.doc(getCurrentUserId());
    userDoc.update({
      "score" : 0
    });
  }

  ///groups
  //crea el grupo en la coleccion 'grupos' y agregar el id del grupo al usuario actual
  Future<String> addGroup(Group group) async {
    String id = await groupService.addGroup(group);
    if (id == "-1") {
      return id;
    }
    final userDoc = userRef.doc(getCurrentUserId());
    userDoc.update({
      "groups": FieldValue.arrayUnion([id])
    });
    return id;
  }

  //borra al grupo de la coleccion 'grupos' y saca el id del grupo del usuario actual
  Future<void> deleteGroup(String groupId) async {
    groupService.deleteGroup(groupId);
    final userDoc = userRef.doc(getCurrentUserId());
    userDoc.update({
      "groups": FieldValue.arrayRemove([groupId])
    });
  }

  ///action
  // Future<void> addAction(MyAction action) async {
  //   addScore(action.score);
  //
  //   //gargar accion a todos los grupos del usuario
  //   userRef.doc(getCurrentUserId()).collection(MyAction.collection_id).add(
  //       action.toMap());
  // }

    //gargar accion a todos los grupos del usuario
    userRef.doc(getCurrentUserId()).collection(MyAction.collection_id).add(
        action.toMap());
  }
  //
  // Future<List<MyAction>> getUserAction() async {
  //   QuerySnapshot qs = await userRef.doc(getCurrentUserId()).collection(
  //       MyAction.collection_id).get();
  //   return qs.docs
  //       .map((value) =>
  //       MyAction.fromSnapshot(value.id, value.data() as Map<String, dynamic>))
  //       .toList();
  // }
}
