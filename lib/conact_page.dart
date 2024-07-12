import 'package:contact_app/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class ContactPage extends StatelessWidget {
  ContactPageController controller = Get.put(ContactPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Center(
          child: Text(
            'Contacts List',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GetX<ContactPageController>(
          builder: (controller) {
            return Column(
              children: [
                SizedBox(height: 10),
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    hintText: 'Contact Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controller.contactController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: 'Contact Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      onPressed: () {
                        controller.save();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () { controller.updateContact();},
                      style: ElevatedButton.styleFrom(primary: Colors.purple),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                controller.information.isEmpty
                    ? Text(
                  'No Contact Yet ..',
                  style: TextStyle(fontSize: 22),
                )
                    : Expanded(
                  child: ListView.builder(
                    itemCount: controller.information.length,
                    itemBuilder: (context, index) => getRow(index),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return GetX<ContactPageController>(
      builder: (controller) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
              foregroundColor: Colors.white,
              child: Text(
                controller.information[index].name[0],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.information[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(controller.information[index].number),
              ],
            ),
            trailing: SizedBox(
              width: 70,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.edit(index);
                    },
                    child: const Icon(Icons.edit),
                  ),
                  InkWell(
                    onTap: () {
                      controller.information.removeAt(index);
                    },
                    child: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
