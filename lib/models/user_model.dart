class AppUser {
  final String id;
  final String name;
  final String? email;
  final String? photoUrl;

  const AppUser({
    required this.id,
    required this.name,
    this.email,
    this.photoUrl,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
      };

  factory AppUser.fromMap(Map<String, dynamic> map) => AppUser(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        photoUrl: map['photoUrl'],
      );
}
