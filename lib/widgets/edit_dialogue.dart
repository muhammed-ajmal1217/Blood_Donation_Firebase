import 'dart:io';

import 'package:firebase/controller/data_provider.dart';
import 'package:firebase/controller/firebase_provider.dart';
import 'package:firebase/helpers/textfields.dart';
import 'package:firebase/model/data_model.dart';
import 'package:firebase/service/database_service.dart';
import 'package:firebase/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditDialogue extends StatefulWidget {
  DataModel donators;
  String id;
  EditDialogue({super.key, required this.donators, required this.id});

  @override
  State<EditDialogue> createState() => _EditDialogueState();
}

class _EditDialogueState extends State<EditDialogue> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.donators.name);
    ageController = TextEditingController(text: widget.donators.age);
    phoneController = TextEditingController(text: widget.donators.phone);
    groupController = TextEditingController(text: widget.donators.group);
    Provider.of<Providers>(context, listen: false).file =
        File(widget.donators.image ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: AlertDialog(
        title: Text('Add Item'),
        content: SingleChildScrollView(
          child: Consumer<Providers>(
            builder: (context, provider, child) => Column(
              children: [
                FutureBuilder<File?>(
                  future: Future.value(provider.file),
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      backgroundImage: snapshot.data != null
                          ? FileImage(snapshot.data!)
                          : null,
                    );
                  },
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                    ),
                    TextButton(
                      onPressed: () {
                        provider.getCam(ImageSource.camera);
                      },
                      child: Text('Camera'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        provider.getCam(ImageSource.gallery);
                      },
                      child: Text('Gallery'),
                    ),
                  ],
                ),
                textFields(controller: nameController,text: 'Name'),
                textFields(controller: ageController,text: 'Age'),
                textFields(controller: phoneController,text: 'Mobile'),
                DropDown()
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('save'),
            onPressed: () {
              update();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }



  void update() {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    final pro = Provider.of<Providers>(context, listen: false);
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final group = pro.selectedGroups;
    final updated = DataModel(
        name: name,
        age: age,
        phone: phone,
        group: group,
        image: pro.file!.path);
    provider.updateDonator(widget.id, updated);
    Navigator.pop(context);
  }
}


