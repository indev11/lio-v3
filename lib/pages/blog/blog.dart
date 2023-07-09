import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/colors.dart';
import 'package:project/pages/blog/create.dart';
import 'package:project/pages/blog/comment.dart';
import 'package:like_button/like_button.dart';

class BlogPage extends StatefulWidget {
  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, bool> _likedBlogs = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(73, 130, 189, 237),
      appBar: AppBar(
        title: Text('Let It Out'),
        backgroundColor: primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('blogs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No blogs found'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic>? data =
                  document.data() as Map<String, dynamic>?;

              if (data == null ||
                  data['title'] == null ||
                  data['text'] == null) {
                return SizedBox(); // Skip rendering if data is invalid
              }

              String blogId = document.id;
              String title = data['title'] as String;
              String text = data['text'] as String;
              bool isLiked = _likedBlogs[blogId] ?? false;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentPage(blogId),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            text,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              LikeButton(
                                size: 24.0,
                                isLiked: isLiked,
                                onTap: (bool isLiked) {
                                  setState(() {
                                    _likedBlogs[blogId] = !isLiked;
                                  });
                                  return Future.value(!isLiked);
                                },
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.favorite,
                                    color: isLiked ? Color.fromARGB(255, 40, 142, 201) : Colors.black,
                                  );
                                },
                                animationDuration: Duration(milliseconds: 500),
                                likeCount: null,
                              ),
                              SizedBox(width: 8.0),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CommentPage(blogId),
                                    ),
                                  );
                                },
                                child: Icon(Icons.comment),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
