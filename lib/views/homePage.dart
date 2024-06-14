import 'package:booking_project/views/postScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'add.comment.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
   var cat = [
    'Hamamamt',
    'sousse',
    'Jerba',
    'Nabeul',
  ];
  final CollectionReference _hotels =
      FirebaseFirestore.instance.collection('hotel');
  TextEditingController _searchController = TextEditingController();
  // void _deleteElement(DocumentReference docRef) async {
  //   try {
  //     await docRef.delete();
  //   } catch (e) {
  //     print(e);
  //   }
  //   setState(() {});
  // }
  void _deleteElement(DocumentReference docRef) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure you want to delete this element?'),
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

  late String _display;
  initState() {}
  Stream<QuerySnapshot> _runFilter(String searchTerm) {
    if (searchTerm.isEmpty) {
      // If the search term is empty, retrieve all the documents from the Firestore
      var result = FirebaseFirestore.instance.collection('hotel').snapshots();
      print('affichaaage de tout les items');
      print(result);
      setState(() {});
      return result;
    } else {
      // Otherwise, retrieve the documents that match the search term
      var result = FirebaseFirestore.instance
          .collection('hotel')
          .orderBy('titre')
          .startAt([searchTerm]).endAt([searchTerm + '\uf8ff']).snapshots();

      result.listen((snapshot) {
        if (snapshot.docs.length == 0) {
          print("No documents found.");
          setState(() {
            _display = "No documents found.";
          });
        }
      });
      print('affichage ddes items specifique');
      print(result);
      setState(() {});
      return result;
    }
  }

  bool _showSearch = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: Padding(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              _runFilter(_searchController.text.toString());
              print('it is runnig');
              print(
                _searchController.text.toString(),
              );
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: 'recherche...',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.blue,
                )),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            height: 200,
                            child: StreamBuilder<QuerySnapshot>(
                              stream:
                                  _runFilter(_searchController.text.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (snapshot.hasData) {
                                  List<DocumentSnapshot> documents =
                                      snapshot.data!.docs;
                                  List<Map> items = documents
                                      .map((e) => e.data() as Map)
                                      .toList();

                                  return ListView.builder(
                                      itemCount: items.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Map thisItem = items[index];
                                        return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PostScreen(),
                                                  ));
                                            },
                                            child: Container(
                                              width: 160,
                                              padding: EdgeInsets.all(20),
                                              margin: EdgeInsets.only(left: 15),
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        thisItem['image']),
                                                    fit: BoxFit.cover,
                                                    opacity: 0.7,
                                                  )),
                                              child: Column(
                                                children: [
                                                  Spacer(),
                                                  Container(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Text(
                                                      thisItem['titre'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ));
                                      });
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ))),
                  ],
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        for (int i = 0; i < 4; i++)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                  )
                                ]),
                            child: Text(
                              cat[i],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SafeArea(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _runFilter(_searchController.text.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.hasData) {
                            QuerySnapshot<Object?>? querySnapshot =
                                snapshot.data;
                            List<QueryDocumentSnapshot> documents =
                                querySnapshot!.docs;
                            List<Map> items =
                                documents.map((e) => e.data() as Map).toList();
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  Map thisItem = items[index];
                                  DocumentSnapshot document =
                                      snapshot.data!.docs[index];
                                  DocumentReference docRef = document.reference;

                                  final titre = document['titre'];
                                  final comments = FirebaseFirestore.instance
                                      .collection('hotel')
                                      .doc(document.id)
                                      .collection('comments')
                                      .snapshots();

                                  return Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PostScreen(),
                                                ));
                                          },
                                          child: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      thisItem['image']),
                                                  fit: BoxFit.cover,
                                                  opacity: 0.7,
                                                )),
                                            child: Column(
                                              children: [
                                                Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    padding: EdgeInsets.only(
                                                        top: 10, right: 10),
                                                   ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                thisItem['titre'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Icon(Icons.more_vert, size: 30),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(children: [
                                          InkWell(
                                            child: Icon(
                                              Icons.comment,
                                              color: Colors.black,
                                              size: 25,
                                            ),
                                            focusColor: Colors.blue,
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        add_comment(
                                                            docRef: docRef,
                                                            titre: titre),
                                                  ));
                                            },
                                          ),
                                          StreamBuilder<QuerySnapshot>(
                                              stream: comments,
                                              builder:
                                                  (context, commentSnapshot) {
                                                if (commentSnapshot.hasError) {
                                                  return Text(
                                                      'Error: ${commentSnapshot.error}');
                                                }
                                                if (commentSnapshot.hasData) {
                                                  int commentsCount =
                                                      commentSnapshot
                                                          .data!.docs.length;

                                                  return Text(
                                                      commentsCount.toString());
                                                }
                                                return Text('loading');
                                              })
                                        ])
                                      ],
                                    ),
                                  );
                                });
                          }
                          return Center(child: CircularProgressIndicator());
                        }))
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: MyApp()
    );
  }
}