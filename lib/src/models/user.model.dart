class UserModel {
  int idx;
  String email;
  String firebaseUid;
  String name;
  String nickname;
  int photoIdx;
  String photoUrl;
  int point;
  String block;
  String phoneNo;
  String gender;
  int birthdate;
  String domain;
  String countryCode;
  String province;
  String city;
  String address;
  String zipcode;
  String provider;
  String verifier;
  int createdAt;
  int updatedAt;
  String sessionId;
  String admin;
  String nicknameOrName;
  int age;
  String verified;

  UserModel({
    this.idx = 0,
    this.email = '',
    this.firebaseUid = '',
    this.name = '',
    this.nickname = '',
    this.photoIdx = 0,
    this.photoUrl = '',
    this.point = 0,
    this.block = '',
    this.phoneNo = '',
    this.gender = '',
    this.birthdate = 0,
    this.domain = '',
    this.countryCode = '',
    this.province = '',
    this.city = '',
    this.address = '',
    this.zipcode = '',
    this.provider = '',
    this.verifier = '',
    this.createdAt = 0,
    this.updatedAt = 0,
    this.sessionId = '',
    this.admin = '',
    this.nicknameOrName = '',
    this.age = 0,
    this.verified = '',
  });

  bool get loggedIn => idx > 0;
  bool get hasPhoto => photoIdx > 0;

  /// JSON 을 문자열로 변환한 것으로, JSON encode 용도로 사용하지 않도록 주의 한다.
  /// 즉, encode 가 필요한 경우는 jsonEncode(user.toJson()) 와 같이 한다.
  @override
  String toString() {
    return toJson().toString();
  }

  /// 빈 값으로 사용자 모델 초기화
  ///
  /// @usage 회원 정보가 없는 임시 사용자 모델을 만들 때 사용한다. 예) 사용자 변수를 만들고 초기값을 지정하려고 할 때
  ///
  /// @example 사용자 변수에 임시 값 지정 예
  /// ```dart
  /// UserModel user = UserModel.init();
  /// ```
  @Deprecated('UserModel() 을 사용 할 것')
  factory UserModel.init() {
    return UserModel.fromJson({'idx': 0});
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idx: json['idx'] as int,
      email: json['email'] ?? '',
      firebaseUid: json['firebaseUid'] ?? '',
      name: json['name'] ?? '',
      nickname: json['nickname'] ?? '',
      photoIdx: json['photoIdx'] ?? 0,
      photoUrl: json['photoUrl'] ?? '',
      point: json['point'] ?? 0,
      block: json['block'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      gender: json['gender'] ?? '',
      birthdate: json['birthdate'] ?? 0,
      domain: json['domain'] ?? '',
      countryCode: json['countryCode'] ?? '',
      province: json['province'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      zipcode: json['zipcode'] ?? '',
      provider: json['provider'] ?? '',
      verifier: json['verifier'] ?? '',
      createdAt: json['createdAt'] ?? 0,
      updatedAt: json['updatedAt'] ?? 0,
      sessionId: json['sessionId'] ?? '',
      admin: json['admin'] ?? '',
      nicknameOrName: json['nicknameOrName'] ?? '',
      age: json['age'] ?? 0,
      verified: json['verified'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'email': email,
      'firebaseUid': firebaseUid,
      'name': name,
      'nickname': nickname,
      'photoIdx': photoIdx,
      'photoUrl': photoUrl,
      'point': point,
      'block': block,
      'phoneNo': phoneNo,
      'gender': gender,
      'birthdate': birthdate,
      'domain': domain,
      'countryCode': countryCode,
      'province': province,
      'city': city,
      'address': address,
      'zipcode': zipcode,
      'provider': provider,
      'verifier': verifier,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'sessionId': sessionId,
      'admin': admin,
      'nicknameOrName': nicknameOrName,
      'age': age,
      'verified': verified,
    };
  }
}
