import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentPage extends StatefulWidget {
  final String blogId;

  CommentPage(this.blogId);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _commentController = TextEditingController();
  FocusNode _commentFocusNode = FocusNode();
  bool _isCommentExpanded = false;

  @override
  void initState() {
    super.initState();
    _commentFocusNode.addListener(_onCommentFocusChange);
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.removeListener(_onCommentFocusChange);
    _commentFocusNode.dispose();
    super.dispose();
  }

  void _onCommentFocusChange() {
    setState(() {
      _isCommentExpanded = _commentFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Color(0xFF111634),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('blogs')
                  .doc(widget.blogId)
                  .collection('comments')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No comments found'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic>? data =
                        document.data() as Map<String, dynamic>?;

                    if (data == null ||
                        data['comment'] == null ||
                        data['timestamp'] == null) {
                      return SizedBox(); // Skip rendering if data is invalid
                    }

                    String comment = data['comment'] as String;
                    Timestamp timestamp = data['timestamp'] as Timestamp;
                    DateTime dateTime = timestamp.toDate();

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.account_circle),
                                      SizedBox(width: 8.0),
                                      Flexible(
                                        child: Text(
                                          comment,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 4.0,
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Text(
                                        '${dateTime.hour}:${dateTime.minute}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    focusNode: _commentFocusNode,
                    maxLines: _isCommentExpanded ? null : 1,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Add a comment',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (comment) {
                      if (comment.trim().isNotEmpty) {
                        _firestore
                            .collection('blogs')
                            .doc(widget.blogId)
                            .collection('comments')
                            .add({
                          'comment': comment,
                          'timestamp': Timestamp.now(),
                        });
                        _commentController.clear();
                      }
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    String comment = _commentController.text.trim();
                    if (comment.isNotEmpty) {
                      _firestore
                          .collection('blogs')
                          .doc(widget.blogId)
                          .collection('comments')
                          .add({
                        'comment': comment,
                        'timestamp': Timestamp.now(),
                      });
                      _commentController.clear();
                    }
                  },
                  child: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF111634),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
