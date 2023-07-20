import 'package:cross_link/src/domain/models/user_links.dart';
import 'package:equatable/equatable.dart';

class UserLinksResponse extends Equatable {
  final String status;
  final int totalResults;
  final List<UserLinks> userLinks;

  const UserLinksResponse({
    required this.status,
    required this.totalResults,
    required this.userLinks
  });

  factory UserLinksResponse.fromMap(Map<String, dynamic> map) {
    return UserLinksResponse(
      status: (map['status'] ?? '') as String,
      totalResults: (map['totalResults'] ?? 0) as int,
      userLinks: List<UserLinks>.from(
        (map['userLinks'] as List<int>).map<UserLinks>(
          (x) => UserLinks.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, totalResults, userLinks];

}