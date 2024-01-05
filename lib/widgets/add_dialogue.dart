import 'dart:io';
import 'package:firebase/controller/data_provider.dart';
import 'package:firebase/controller/firebase_provider.dart';
import 'package:firebase/helpers/textfields.dart';
import 'package:firebase/model/data_model.dart';
import 'package:firebase/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddingDialogue extends StatelessWidget {
  AddingDialogue({super.key});

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

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
                  future: Future.value(Provider.of<Providers>(context).file),
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
                        Provider.of<Providers>(context, listen: false)
                            .getCam(ImageSource.camera);
                      },
                      child: Text('Camera'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Providers>(context, listen: false)
                            .getCam(ImageSource.gallery);
                      },
                      child: Text('Gallery'),
                    ),
                  ],
                ),
                textFields(controller: nameController, text: 'Name'),
                textFields(controller: ageController, text: 'Age'),
                textFields(controller: phoneController, text: 'Mobile'),
                DropDown()
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () {
              addData(context);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  addData(BuildContext context) async{
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    final pro=Provider.of<Providers>(context, listen: false);
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final group = pro.selectedGroups;
    await provider.imageAdder(File(pro.file!.path));
    final data = DataModel(
        name: name, age: age, phone: phone, group: group, image: provider.downloadurl);
    provider.addDonator(data);
  }
}
