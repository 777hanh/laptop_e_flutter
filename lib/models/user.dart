class UserModel {
  final String userName, userEmail, userGender, userPhoneNumber, userId;
  String? address;

  UserModel({
    this.userId = '',
    this.userName = '',
    this.userEmail = '',
    this.userGender = 'Male',
    this.userPhoneNumber = '',
    this.address = '',
  });
}

UserModel demoUser = UserModel(
    userId: 'demouserid',
    userName: 'banhcanh',
    userEmail: 'banhcanh@gmail.com',
    userGender: 'Male',
    userPhoneNumber: '0987654321',
    address: '123 Thanh Thai',
    );
