import 'package:church_clique/features/auth/models/user_model.dart';

class MembershipModel {
  final int? id;
  final int userId;
  final String fullName;
  final String dateOfBirth;
  final String dateOfRegistration;
  final String amountPaid;
  final String amountInWords;
  final String receiptNo;
  final int contact;
  final String houseNo;
  final String placeOfAbode;
  final String landmark;
  final String homeTown;
  final String region;
  final String maritalStatus;
  final String others;
  final String? nameOfSpouse;
  final String? lifeStatus;
  final String? numberOfChildren;
  final String? namesOfChildren;
  final String occupation;
  final String fatherName;
  final String fLifeStatus;
  final String motherName;
  final String mLifeStatus;
  final String nextOfKin;
  final int nextOfKinContact;
  final String classLeader;
  final int classLeaderContact;
  final String? orgMember;
  final int? orgLeaderContact;

  MembershipModel({
    this.id,
    required this.userId,
    required this.fullName,
    required this.dateOfBirth,
    required this.dateOfRegistration,
    required this.amountPaid,
    required this.amountInWords,
    required this.receiptNo,
    required this.contact,
    required this.houseNo,
    required this.placeOfAbode,
    required this.landmark,
    required this.homeTown,
    required this.region,
    required this.maritalStatus,
    required this.others,
    required this.nameOfSpouse,
    required this.lifeStatus,
    required this.numberOfChildren,
    required this.namesOfChildren,
    required this.occupation,
    required this.fatherName,
    required this.fLifeStatus,
    required this.motherName,
    required this.mLifeStatus,
    required this.nextOfKin,
    required this.nextOfKinContact,
    required this.classLeader,
    required this.classLeaderContact,
    required this.orgMember,
    required this.orgLeaderContact,
  });

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      id: json["id"] as int? ,
      userId: json["id"],
      fullName: json['fullName'] ?? '',
      dateOfBirth: json['dateOfBirth']  ?? "",
      dateOfRegistration: json['dateOfRegistration'] ?? "",
      amountPaid: json['amountPaid'] ?? '',
      amountInWords: json['amountInWords'] ?? '',
      receiptNo: json['receiptNo'] ?? '',
      contact: json['contact'],
      houseNo: json['houseNo'] ?? '',
      placeOfAbode: json['placeOfAbode'] ?? '',
      landmark: json['landmark'] ?? '',
      homeTown: json['homeTown'] ?? '',
      region: json['region'] ?? '',
      maritalStatus: json['maritalStatus'] ?? '',
      others: json['others'] ?? '',
      nameOfSpouse: json['nameOfSpouse'] != null ? json['nameOfSpouse'] : null,
      lifeStatus: json['lifeStatus'] != null ? json['lifeStatus'] : null,
      numberOfChildren: json['numberOfChildren'] !=null ? json['numberOfChildren'] : null,
      namesOfChildren: json['namesOfChildren'] !=null ? json['namesOfChildren'] : null,
      occupation: json['occupation'] ?? '' ,
      fatherName: json['fatherName'] ?? '',
      fLifeStatus: json['fLifeStatus'] ?? '',
      motherName: json['motherName'] ?? '',
      mLifeStatus: json['mLifeStatus'] ?? '',
      nextOfKin: json['nextOfKin'] ?? '',
      nextOfKinContact: json['nextOfKinContact'] ?? 0,
      classLeader: json['classLeader'] ?? '',
      classLeaderContact: json['classLeaderContact'] ?? 0,
      orgMember: json['orgMember'] != null ? json['orgMember'] :null,
      orgLeaderContact: json['orgLeader'] != null ? json['orgLeader'] :null,
    );
  }
}
