
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'information.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Information> information = List.empty(growable: true);
  int selectedIndex = -1;

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
        child: Column(
          children: [
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Contact Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: contactController,
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
                    String name = nameController.text.trim();
                    String contact = contactController.text.trim();
                    if (name.isNotEmpty && contact.isNotEmpty) {
                      setState(() {
                        nameController.text = "";
                        contactController.text = "";
                        information.add(Information(name: name, number: contact));
                      });
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedIndex >= 0 && selectedIndex < information.length) {
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          information[selectedIndex] = Information(name: name, number: contact);
                          nameController.text = "";
                          contactController.text = "";
                          selectedIndex = -1;
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            information.isEmpty
                ? Text(
              'No Contact Yet ..',
              style: TextStyle(fontSize: 22),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: information.length,
                itemBuilder: (context, index) => getRow(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            information[index].name[0],
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              information[index].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(information[index].number),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    nameController.text = information[index].name;
                    contactController.text = information[index].number;
                  });
                },
                child: const Icon(Icons.edit),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    information.removeAt(index);
                  });
                },
                child: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
