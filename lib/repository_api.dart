import 'dart:io';

import 'package:contact_app/contact_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer' as developer;
import 'dart:convert';

class RepositoryApi {
  Future<ContactResponseModel> putContact(
      Map<String, dynamic> json, int id) async {
    try {
      var response =
          await Dio().put('http://127.0.0.1:8000/api/contacts/$id', data: json);
      return ContactResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      print("errror $e");
      return ContactResponseModel.fromJson(e.response?.data);
    }
  }

  Future<ContactResponseModel> postContact(Map<String, dynamic> json) async {
    try {
      var response =
          await Dio().post('http://127.0.0.1:8000/api/contacts/', data: json);
      return ContactResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      print("errror $e");
      return ContactResponseModel.fromJson(e.response?.data);
    }
  }

  Future<ContactResponseModel> getContacts() async {
    try {
      var response = await Dio().get('http://127.0.0.1:8000/api/contacts/');
      return ContactResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      print("errror $e");
      return ContactResponseModel.fromJson(e.response?.data);
    }
  }

  Future<ContactResponseModel> getContact({required int id}) async {
    try {
      var response = await Dio().get('http://127.0.0.1:8000/api/contacts/$id');
      return ContactResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      print("errror $e");
      return ContactResponseModel.fromJson(e.response?.data);
    }
  }

  Future<ContactResponseModel> deleteContact({required int id}) async {
    try {
      var response =
          await Dio().delete('http://127.0.0.1:8000/api/contacts/$id');
      return ContactResponseModel.fromJson({
        "message": "berhasil",
        "data": {"firstname": "", "lastname": "", "phone_number": ""}
      });
    } on DioError catch (e) {
      print("errror $e");
      return ContactResponseModel.fromJson(e.response?.data);
    }
  }
}
