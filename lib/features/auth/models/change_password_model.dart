class ChangePasswordModel {
  
  final int affectedRows;

  ChangePasswordModel({required this.affectedRows});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json){
    return ChangePasswordModel(affectedRows: json['affectedRows']);
  }
}