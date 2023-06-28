import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:happy_paws/service/marker_operations.dart';

final usersDb = FirebaseFirestore.instance.collection('users');
final placesDb = FirebaseFirestore.instance.collection('places');
final ngoDb = FirebaseFirestore.instance.collection('ngos');
final markerOperations = MarkerOperations();
