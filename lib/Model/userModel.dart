class UserModel {
  int? _id;
  late String _firstName;
  late String _lastName;
  late String _address;
  late String _email;
  late String _phoneNum;
  late String _gender;
  late String _imagePath;
  late double _userMapLat;
  late double _userMapLong;
  UserModel(dynamic obj){
    _id = obj['id'];
    _firstName = obj['firstName'];
    _lastName = obj['lastName'];
    _address = obj['address'];
    _email = obj['email'];
    _phoneNum = obj['phoneNum'];
    _gender = obj['gender'];
    _imagePath = obj['imagePath'];
    _userMapLat = obj['userMapLat'];
    _userMapLong = obj['userMapLong'];
  }
  UserModel.fromMap(Map<String,dynamic>data){
    _id = data['id'];
    _firstName = data['firstName'];
    _lastName = data['lastName'];
    _address = data['address'];
    _email = data['email'];
    _phoneNum = data['phoneNum'];
    _gender = data['gender'];
    _imagePath = data['imagePath'];
    _userMapLat = data['userMapLat'];
    _userMapLong = data['userMapLong'];
  }

  Map<String ,dynamic> toMap()=>{
    'id' : _id,
    'firstName' : _firstName,
    'lastName' : _lastName,
    'email': _email,
    'address' : _address,
    'phoneNum': _phoneNum,
    'gender':_gender,
    'imagePath':_imagePath,
    'userMapLat':_userMapLat,
    'userMapLong':_userMapLong

  };

  int? get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get address => _address;
  String get email => _email;
  String get phoneNum => _phoneNum;
  String get gender => _gender;
  String get imagePath =>_imagePath;
  double get userMapLat => _userMapLat;
  double get userMapLong => _userMapLong;

}