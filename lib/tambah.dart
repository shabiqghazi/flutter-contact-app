import 'package:contact_app/repository_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  RepositoryApi repositoryApi = new RepositoryApi();
  final _firstnameInput = TextEditingController();
  final _lastnameInput = TextEditingController();
  final _phone_numberInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Kontak"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                  controller: _firstnameInput,
                  inputFormatters: [LengthLimitingTextInputFormatter(25)],
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'First Name', icon: Icon(Icons.person))),
              TextFormField(
                  controller: _lastnameInput,
                  inputFormatters: [LengthLimitingTextInputFormatter(25)],
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'Last Name',
                      icon: Icon(Icons.check_box_outline_blank))),
              TextFormField(
                  controller: _phone_numberInput,
                  inputFormatters: [LengthLimitingTextInputFormatter(25)],
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'No. HP', icon: Icon(Icons.phone))),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: ElevatedButton(
                    onPressed: () {
                      addContact();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey[700]),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 40)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ))),
                    child: const Text("Simpan")),
              ),
            ],
          )),
    );
  }

  addContact() {
    var contact = {
      "firstname": _firstnameInput.text,
      "lastname": _lastnameInput.text,
      "phone_number": _phone_numberInput.text
    };
    repositoryApi.postContact(contact).then((value) {
      Navigator.pop(context, "berhasil");
    });
  }
}
