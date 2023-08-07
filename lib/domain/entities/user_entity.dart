class UserEntity {
  int? id;

  int? age;

  String? job;

  String? name;

  String? email;

  String? phoneNumber;
  UserEntity(
      {this.age, this.email, this.id, this.job, this.name, this.phoneNumber});
}
//cái gì mà repo ko cung cấp thì mình sẽ cung cấp trong entity