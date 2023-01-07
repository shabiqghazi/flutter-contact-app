import 'package:contact_app/contact_response_model.dart';
import 'package:contact_app/repository_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditContact extends StatefulWidget {
  int? id;
  EditContact({super.key, this.id});

  @override
  State<EditContact> createState() => _EditContactState(id!);
}

class _EditContactState extends State<EditContact> {
  int id;
  _EditContactState(this.id);
  RepositoryApi repositoryApi = RepositoryApi();
  ContactResponseModel contactResponseModel = ContactResponseModel();
  final _firstnameInput = TextEditingController();
  final _lastnameInput = TextEditingController();
  final _phone_numberInput = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    getApiContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Kontak"),
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
                      updateContact();
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

  getApiContact() {
    repositoryApi.getContact(id: id).then((value) {
      contactResponseModel = value;
      setState(() {
        isLoading = false;
        _firstnameInput.text = contactResponseModel.firstname!;
        _lastnameInput.text = contactResponseModel.lastname!;
        _phone_numberInput.text = contactResponseModel.phone_number!;
      });
    });
  }

  updateContact() {
    var contact = {
      "firstname": _firstnameInput.text,
      "lastname": _lastnameInput.text,
      "phone_number": _phone_numberInput.text
    };
    repositoryApi.putContact(contact, id).then((value) {
      Navigator.pop(context, "berhasil");
    });
  }
}
