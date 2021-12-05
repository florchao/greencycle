import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greencycle/model/MyAction.dart';

class ActionService {
  CollectionReference actionRef = FirebaseFirestore.instance.collection(MyAction.collection_id);

  Future<String?> create(MyAction action) async {
    String? id;
    await actionRef.add(action.toMap()).then((value) => {id = value.id});
    return id;
  }

  Future<void> delete(String actionId) async{
    await actionRef.doc(actionId).delete();
  }


}