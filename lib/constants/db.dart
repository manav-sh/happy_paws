import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happy_paws/service/marker_operations.dart';

final users = FirebaseFirestore.instance.collection('users');
final places = FirebaseFirestore.instance.collection('places');
final ngo = FirebaseFirestore.instance.collection('ngos');
final markerOperations = MarkerOperations();
