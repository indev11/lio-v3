import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/colors.dart';
import 'package:project/pages/blog/blog.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController _blogTitleController = TextEditingController();
  TextEditingController _blogTextController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addBlog(String blogTitle, String blogText) async {
    try {
      if (blogTitle != null &&
          blogTitle.isNotEmpty &&
          blogText != null &&
          blogText.isNotEmpty) {
        await _firestore
            .collection('blogs')
            .add({'title': blogTitle, 'text': blogText});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Blog added successfully')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid blog title and text')),
        );
      }
    } catch (e) {
      print('Error adding blog: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add blog')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Create Blog'),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _blogTitleController,
                decoration: InputDecoration(
                    labelText: 'Blog Title',
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _blogTextController,
                decoration: InputDecoration(
                    labelText: 'Write your blog',
                    labelStyle: TextStyle(color: Colors.black)),
                maxLines: null, // Allow the field to expand downwards
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _addBlog(_blogTitleController.text, _blogTextController.text);
                  _blogTitleController.clear();
                  _blogTextController.clear();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(primary),
                ),
                child: Text('Post Blog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
