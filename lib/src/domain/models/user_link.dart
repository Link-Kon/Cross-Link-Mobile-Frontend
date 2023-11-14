class UserLink {
  final int? id;
  final String? name;
  final String? user1code;
  final String? user2code;
  final bool? state;
  final String? linkDate;
  final String? imageUrl;

  const UserLink({this.id, this.name, this.user1code, this.user2code, this.state, this.linkDate, this.imageUrl});

  factory UserLink.fromJson(Map<String, dynamic> json) {
    return UserLink(
      id: json['id'] as int?,
      name: json['name'] as String?,
      user1code: json['user1Code'] as String,
      user2code: json['user2Code'] as String,
      state: json['state'] as bool,
      linkDate: json['linkDate'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'user1Code': user1code,
      'user2Code': user2code,
      'state': state,
      //'linkDate': linkDate,
      //'imageUrl': imageUrl
    };
  }

}