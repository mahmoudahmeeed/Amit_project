import 'dart:convert';

class JobModel {
  int id;
  String name;
  String image;
  String jobTimeType;
  String jobType;
  String jobLevel;
  String jobDescription;
  String jobSkill;
  String compName;
  String compEmail;
  String compWebsite;
  String aboutComp;
  String location;
  String salary;
  int favorites;
  int expired;
  String createdAt;
  String updatedAt;
  bool? isFavorite;
  JobModel({
    required this.id,
    required this.name,
    required this.image,
    required this.jobTimeType,
    required this.jobType,
    required this.jobLevel,
    required this.jobDescription,
    required this.jobSkill,
    required this.compName,
    required this.compEmail,
    required this.compWebsite,
    required this.aboutComp,
    required this.location,
    required this.salary,
    required this.favorites,
    required this.expired,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'job_time_type': jobTimeType,
      'job_type': jobType,
      'job_level': jobLevel,
      'job_description': jobDescription,
      'job_skill': jobSkill,
      'comp_name': compName,
      'comp_email': compEmail,
      'comp_website': compWebsite,
      'about_comp': aboutComp,
      'location': location,
      'salary': salary,
      'favorites': favorites,
      'expired': expired,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_favorite': isFavorite ?? false,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      jobTimeType: map['job_time_type'] as String,
      jobType: map['job_type'] as String,
      jobLevel: map['job_level'] as String,
      jobDescription: map['job_description'] as String,
      jobSkill: map['job_skill'] as String,
      compName: map['comp_name'] as String,
      compEmail: map['comp_email'] as String,
      compWebsite: map['comp_website'] as String,
      aboutComp: map['about_comp'] as String,
      location: map['location'] as String,
      salary: map['salary'] as String,
      favorites: map['favorites'] as int,
      expired: map['expired'] as int,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      isFavorite:
          map['is_favorite'] != null ? map['is_favorite'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) =>
      JobModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobModel(id: $id, name: $name, image: $image, jobTimeType: $jobTimeType, jobType: $jobType, jobLevel: $jobLevel, jobDescription: $jobDescription, jobSkill: $jobSkill, compName: $compName, compEmail: $compEmail, compWebsite: $compWebsite, aboutComp: $aboutComp, location: $location, salary: $salary, favorites: $favorites, expired: $expired, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
