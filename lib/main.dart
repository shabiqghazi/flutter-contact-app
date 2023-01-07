import 'dart:html';

import 'package:contact_app/contact_response_model.dart';
import 'package:contact_app/detail.dart';
import 'package:contact_app/repository_api.dart';
import 'package:contact_app/tambah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IF SGD Contact App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'IF SGD Contact App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RepositoryApi respositoryApi = RepositoryApi();
  ContactResponseModel contactsResponseModel = ContactResponseModel();
  bool isLoading = true;
  final TextEditingController _namaInput = TextEditingController();
  @override
  void initState() {
    getApiContacts();
    super.initState();
  }

  bool _isSearching = false;
  String _searchText = "";
  List searchresult = [];

  _MyHomePageState() {
    _namaInput.addListener(() {
      if (_namaInput.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _namaInput.text;
        });
        searchOperation(_searchText);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(children: [
        Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              controller: _namaInput,
              inputFormatters: [LengthLimitingTextInputFormatter(25)],
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText: 'Search', icon: Icon(Icons.search)),
            )),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            '${contactsResponseModel.contacts?.length} Kontak',
            style: TextStyle(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: searchresult.length != 0 && _namaInput.text.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // ignore: prefer_is_empty
                  itemCount:
                      searchresult.length != null && searchresult.length > 0
                          ? searchresult.length
                          : 0,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ContactDetail(id: searchresult[position].id);
                          }),
                        ).then((value) {
                          _isSearching = false;
                          _searchText = "";
                          getApiContacts();
                        });
                      }),
                      child: Container(
                        color: Color(0xffffff),
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Container(
                                height: 48,
                                width: 48,
                                margin: const EdgeInsets.only(right: 8.0),
                                decoration: const BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)))),
                            Text(
                              '${searchresult[position].firstname} ${searchresult[position].lastname}',
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // ignore: prefer_is_empty
                  itemCount: contactsResponseModel.contacts?.length != null &&
                          contactsResponseModel.contacts!.length > 0
                      ? contactsResponseModel.contacts?.length
                      : 0,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ContactDetail(
                                id: contactsResponseModel
                                    .contacts![position].id);
                          }),
                        ).then((value) {
                          getApiContacts();
                        });
                      }),
                      child: Container(
                        color: Color(0xffffff),
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Container(
                                height: 48,
                                width: 48,
                                margin: const EdgeInsets.only(right: 8.0),
                                decoration: const BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)))),
                            Text(
                              '${contactsResponseModel.contacts?[position].firstname} ${contactsResponseModel.contacts?[position].lastname}',
                            )
                          ],
                        ),
                      ),
                    );
                  }),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContact()),
          ).then((context) {
            getApiContacts();
          });
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.person_add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getApiContacts() {
    _isSearching = false;
    respositoryApi.getContacts().then((value) {
      contactsResponseModel = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < contactsResponseModel.contacts!.length; i++) {
        var data = contactsResponseModel.contacts?[i];
        if (data!.firstname!.toLowerCase().contains(searchText.toLowerCase()) ||
            data.lastname!.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}
