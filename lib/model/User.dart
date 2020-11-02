

class User{

  final int userId;
  final String userName;
  final String userLastName;
  final String userEmail;
  final String userPassword;
  final String userProfilePhoto;
  final String userCreatedAt;
  final String userTelephoneNumber;
  final String userRole;

  User(
  {   this.userId,
      this.userName,
      this.userLastName,
      this.userEmail,

      this.userPassword,
      this.userProfilePhoto,
      this.userCreatedAt,
      this.userTelephoneNumber,
      this.userRole});

  factory User.fromJson(Map<String,dynamic>json){
    return User(
        userId: json['id'],
        userName:json['name'],
        userLastName:json['lastName'],
        userProfilePhoto:json['profilePhoto'],
        userPassword:json['password'],
        userTelephoneNumber:json['telephoneNumber'],
        userEmail:json['email'],
        userCreatedAt:json['createdAt'],
        userRole:json['role']);
  }
}