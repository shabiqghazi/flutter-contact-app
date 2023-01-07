class ContactResponseModel {
  int? id;
  String? firstname;
  String? lastname;
  String? phone_number;
  List<Contacts>? contacts;

  ContactResponseModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.phone_number,
      this.contacts});

  ContactResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'].runtimeType == List<dynamic>) {
      contacts = <Contacts>[];
      json['data'].forEach((v) {
        // print(v);
        contacts!.add(new Contacts.fromJson(v));
      });
    } else {
      id = json['data']['id'];
      firstname = json['data']['firstname'];
      lastname = json['data']['lastname'];
      phone_number = json['data']['phone_number'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phone_number'] = phone_number;
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  int? id;
  String? firstname;
  String? lastname;
  String? phone_number;

  Contacts({this.id, this.firstname, this.lastname, this.phone_number});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone_number = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['phone_number'] = phone_number;

    return data;
  }
}
