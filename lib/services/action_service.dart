import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greencycle/model/MyAction.dart';

class UserService {
  CollectionReference actionRef = FirebaseFirestore.instance.collection(MyAction.collection_id);

  Future<void> create(MyAction action) async {
    
  }



}