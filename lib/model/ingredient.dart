import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final DocumentReference? reference;
  late final String name;

  Ingredient.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'];

  Ingredient.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => name;
}
