import 'package:church_clique/features/auth/models/user_model.dart';

class MembershipModel {
  final int userId;
  final String fullName;
  final String dateOfBirth;
  final String dateOfRegistration;
  final String amountPaid;
  final String amountInWords;
  final String receiptNo;
  final String contact;
  final String houseNo;
  final String placeOfAbode;
  final String landmark;
  final String homeTown;
  final String region;
  final String maritalStatus;
  final String others;
  final String nameOfSpouse;
  final String lifeStatus;
  final String numberOfChildren;
  final String namesOfChildren;
  final String occupation;
  final String fatherName;
  final String fLifeStatus;
  final String motherName;
  final String mLifeStatus;
  final String nextOfKin;
  final String nextOfKinContact;
  final String classLeader;
  final String classLeaderContact;
  final String orgMember;
  final String orgLeaderContact;

  MembershipModel({
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
      userId: User.fromJson (json['id']) as int,
      fullName: json['fullName'] as String,
      dateOfBirth: json['dateOfBirth'],
      dateOfRegistration: json['dateOfRegistration'],
      amountPaid: json['amountPaid'],
      amountInWords: json['amountInWords'],
      receiptNo: json['receiptNo'],
      contact: json['contact'],
      houseNo: json['houseNo'],
      placeOfAbode: json['placeOfAbode'],
      landmark: json['landmark'],
      homeTown: json['homeTown'],
      region: json['region'],
      maritalStatus: json['maritalStatus'],
      others: json['others'],
      nameOfSpouse: json['nameOfSpouse'],
      lifeStatus: json['lifeStatus'],
      numberOfChildren: json['numberOfChildren'],
      namesOfChildren: json['namesOfChildren'],
      occupation: json['occupation'],
      fatherName: json['fatherName'],
      fLifeStatus: json['fLifeStatus'],
      motherName: json['motherName'],
      mLifeStatus: json['mLifeStatus'],
      nextOfKin: json['nextOfKin'],
      nextOfKinContact: json['nextOfKinContact'],
      classLeader: json['classLeader'],
      classLeaderContact: json['classLeaderContact'],
      orgMember: json['orgMember'],
      orgLeaderContact: json['orgLeader'],
    );
  }
}
