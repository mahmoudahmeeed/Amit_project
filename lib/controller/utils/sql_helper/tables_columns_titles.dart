part of 'sql_helper.dart';

/// for statndard column titles
class UserTableColumnTitles {
  static const String usersTable = 'Users';
  static const String id = 'id';
  static const String name = 'name';
  static const String otp = 'otp';
  static const String towStep = 'tow_step';
  static const String email = 'email';
  static const String emailVerifiedAt = 'email_verified_at';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String token = 'token';
  static const String careerType = 'work_type';
  static const String workNature = 'work_nature';
  static const String workLocations = 'work_locations';
  static const String login = 'login';
  static const String profileImage = 'profile_image';
  static const String mobile = 'mobile';
  static const String bio = 'bio';
  static const String address = 'address';
}

class SavedJobTableColumnTitles {
  static String jobTable = 'favorite_job';
  static String createdAt = 'created_at';
}

class AppliedJobTableColumnTitles {
  static const String jobTable = 'applied_job';
  static String createdAt = 'created_at';
}

class DatabseJobTableColumnTitles {
  static String jobId = 'job_id';
  static String name = 'name';
  static String image = 'image';
  static String compName = 'comp_name';
}
