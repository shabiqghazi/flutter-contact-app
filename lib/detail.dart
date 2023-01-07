import 'dart:ui';

import 'package:contact_app/contact_response_model.dart';
import 'package:contact_app/main.dart';
import 'package:contact_app/repository_api.dart';
import 'package:contact_app/ubah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactDetail extends StatefulWidget {
  int? id;
  ContactDetail({super.key, this.id});

  @override
  State<ContactDetail> createState() => _ContactDetailState(id!);
}

class _ContactDetailState extends State<ContactDetail> {
  int id;
  _ContactDetailState(this.id);
  RepositoryApi repositoryApi = RepositoryApi();
  ContactResponseModel contactResponseModel = ContactResponseModel();
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
        title: const Text('Detail Contact'),
      ),
      body: Column(children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              height: 256,
              width: double.infinity,
              color: Colors.blueGrey[700],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 24, left: 24),
              child: Row(
                children: [
                  Container(
                      height: 56,
                      width: 56,
                      decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(28)))),
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${contactResponseModel.firstname} ${contactResponseModel.lastname}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  '${contactResponseModel.phone_number}',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  "Seluler | Indonesia",
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditContact(id: id)),
                          ).then((value) => getApiContact());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueGrey[700]),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 40)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ))),
                        child: const Text("Edit Kontak")),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        deleteContact(context);
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
                      child: const Text("Hapus Kontak")),
                ],
              ),
            )
          ]),
        )
      ]),
    );
  }

  deleteContact(context) {
    repositoryApi.deleteContact(id: id).then((value) {
      Navigator.pop(context, "data");
      setState(() {
        isLoading = false;
      });
    });
  }

  getApiContact() {
    repositoryApi.getContact(id: id).then((value) {
      contactResponseModel = value;
      setState(() {
        isLoading = false;
      });
    });
  }
}
