import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/controller/firebase_provider.dart';
import 'package:firebase/model/data_model.dart';
import 'package:firebase/widgets/add_dialogue.dart';
import 'package:firebase/widgets/edit_delete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ui dull');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Blood Donation',
          style: GoogleFonts.almarai(fontWeight: FontWeight.w800),
        ),
        elevation: 0,
      ),
      body: Consumer<FirebaseProvider>(builder: (context, provider, child) {
        print('only this');
        return StreamBuilder<QuerySnapshot<DataModel>>(
          stream: provider.getDoners(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            List<QueryDocumentSnapshot<DataModel>> donatorDocs =
                snapshot.data?.docs ?? [];

            return ListView.separated(
              itemCount: donatorDocs.length,
              itemBuilder: (context, index) {
                DataModel donator = donatorDocs[index].data();
                final id = donatorDocs[index].id;

                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: donator.image != null
                        ? FileImage(File(donator.image!))
                        : null,
                  ),
                  title: Text(
                    donator.name ?? '',
                    style: GoogleFonts.figtree(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(donator.age ?? ''),
                      Text(donator.phone ?? ''),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(donator.group ?? '',
                          style: GoogleFonts.acme(
                              color: const Color.fromARGB(255, 90, 10, 4),
                              fontSize: 25)),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return EditDelete(
                                donators: donator,
                                id: id,
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddingDialogue();
            },
          );
        },
      ),
    );
  }
}
