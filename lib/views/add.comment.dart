import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class add_comment extends StatefulWidget {
  final DocumentReference docRef;
  const add_comment({key, required this.docRef, required titre})
      : super(key: key);

  @override
  State<add_comment> createState() => _add_commentState();
}

class _add_commentState extends State<add_comment> {
  TextEditingController commentController = TextEditingController();
  late String titre;
  @override
  void initState() {
    super.initState();
    widget.docRef.get().then((value) {
      if (value.exists) {
        setState(() {
          titre = (value.data() as Map<String, dynamic>)['titre'];
        });
      }
    });
  }

  void _deleteElement(DocumentReference docRef) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure you want to delete this comment?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm) {
      try {
        await docRef.delete();
      } catch (e) {
        print(e);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('hotel')
                .doc(widget.docRef.id)
                .collection('comments')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasData) {
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                List<Map> items =
                    documents.map((e) => e.data() as Map).toList();

                if (snapshot.data != null)
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map comment = items[index];
                        final text = comment['text'].toString();
                        final title = comment['titre'].toString();
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        DocumentReference docRef = document.reference;
                        return ListTile(
                            leading: CircleAvatar(
                              //    backgroundColor: const Color(0xff764abc),
                              backgroundColor:
                                  Color.fromARGB(255, 39, 102, 191),
                              child: Text(text),
                            ),
                            title: Text(text),
                            subtitle: Text(title),
                            // trailing: Row(
                            //   children: [
                            //     InkWell(
                            //       child: Icon(
                            //         Icons.delete,
                            //         color: Colors.white,
                            //         size: 25,
                            //       ),
                            //       focusColor: Colors.blue,
                            //       onTap: () => _deleteElement(docRef),
                            //     ),
                            //     SizedBox(width: 10),
                            //     InkWell(
                            //       child: Icon(
                            //         Icons.edit,
                            //         color: Colors.black,
                            //         size: 25,
                            //       ),
                            //       focusColor: Colors.blue,
                            //       onTap: () {},
                            //     ),
                            //   ],
                            // )
                            trailing: InkWell(
                              child: Icon(
                                Icons.delete,
                                color: Colors.black,
                                size: 25,
                              ),
                              onTap: () => _deleteElement(docRef),
                            ));
                      });
              }
              return Text('loading');
            },
          )),
          Spacer(),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 10, left: 10, bottom: 30, top: 30),
                    child: TextFormField(
                      controller: commentController,
                      minLines: 1,
                      maxLength: 500,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send, color: Colors.blue),
                            onPressed: () async {
                              final snapshot = await widget.docRef.get();
                              final title = titre;
                              final Map<String, dynamic> commentData = {
                                'titre': title,
                                'text': commentController.text,
                              };
                              await FirebaseFirestore.instance
                                  .collection('hotel')
                                  .doc(widget.docRef.id)
                                  .collection('comments')
                                  .add(commentData);
                              // Clear the comment text field
                              commentController.clear();
                              // Show a message to the user
                              // Scaffold.of(context).showSnackBar(
                              //   SnackBar(content: Text('Comment added')
                              //   ),
                              //);
                            },
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "add comment",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ))),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}