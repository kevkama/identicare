import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 
/// so this database stores posts created by users
/// they are stored in a colection called 'posts' in cloud firestore
/// 
/// each post created will contain a msg an username and time stamp

class FirestoreDatabase {
// determine current logged in user
  User? user = FirebaseAuth.instance.currentUser;

// them get collection of posts from Firestore
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

// first method will allow user to post a msg
  Future<void> addPost(String message) {
    return posts.add({
      'userName': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

// second will cater for reading the posts from the database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();

    return postsStream;
  }
}
