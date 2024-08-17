import 'dart:convert';

import 'package:church_clique/features/form/models/membership_model.dart';
import 'package:http/http.dart' as http;

class FormServiceResponse {
  static Future<List<MembershipModel>> getMembershipDetails(
      int id) async {
    final serverUrl = 'http://10.0.2.2:3000/api/v1/get-membership/$id';

    try {
      final response = await http.get(
        Uri.parse(serverUrl),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData= jsonDecode(response.body);
        final List<dynamic> getMembers = responseData['data'];

        final List<MembershipModel> getMembersData =
            getMembers.map((json) => MembershipModel.fromJson(json)).toList();

            print(getMembers);
        return getMembersData;
      }
      // else if(response.statusCode == 404){
      //   return [];
      // }
       else {
        throw Exception("failed to fetch members");
      }
    } on Exception catch (e) {
      throw Exception('an Error occurred: $e');
    }
  }
}
