

class User{

  final int userId;
  final String userEmail;
  final String userPassword;
  final String userProfilePhoto;
  final String userCreatedAt;
  final String userTelephoneNumber;
  final String userRole;
  final String userIsActive;
  final String userLoginName;

  User(
  {   this.userId,
      this.userEmail,
      this.userPassword,
      this.userProfilePhoto,
      this.userCreatedAt,
      this.userTelephoneNumber,
      this.userRole,
      this.userIsActive,
      this.userLoginName});

  factory User.fromJson(Map<String,dynamic>json){
    return User(
        userId: json['id'],
        userProfilePhoto:json['profilePhoto'],
        userPassword:json['password'],
        userTelephoneNumber:json['telephoneNumber'],
        userEmail:json['email'],
        userCreatedAt:json['createdAt'],
        userRole:json['role'],
        userIsActive:json['isActive'],
        userLoginName:json['loginName']);
  }
}