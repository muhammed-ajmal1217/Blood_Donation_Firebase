
import 'package:firebase/controller/firebase_provider.dart';
import 'package:firebase/model/data_model.dart';
import 'package:firebase/widgets/edit_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditDelete extends StatelessWidget {
  DataModel donators;
  String id;
   EditDelete({super.key,required this.donators,required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditDialogue(
                    donators: donators,
                    id: id,
                  );
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
            onTap: () {
              Provider.of<FirebaseProvider>(context,listen: false).deleteDonator(id);
              Provider.of<FirebaseProvider>(context,listen: false).deleteImage(donators.image!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
