
class CompanyModel {
  final String companyName;
  final String companyImage;

  CompanyModel({
    required this.companyName,
    required this.companyImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'companyImage': companyImage,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> json) {
    return CompanyModel(
      companyName: json['companyName'],
      companyImage: json['companyImage'],
    );
  }
}