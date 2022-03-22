import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final DocumentReference? reference;
  final String? name;
  final String? seq;

  Ingredient.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'],
        seq = map['seq'];

  Ingredient.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "$seq $name";
}
