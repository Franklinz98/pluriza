class Post {
  final int _id, _userId;
  final String _title, _body;
  bool read, favorite;

  Post({
    required int id,
    required int userId,
    required String title,
    required String body,
    this.read = true,
    this.favorite = false,
  })  : _id = id,
        _userId = userId,
        _title = title,
        _body = body;

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      body: map['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      'read': read ? 1 : 0,
      'favorite': favorite ? 1 : 0,
    };
  }

  int get id => _id;
  int get userId => _userId;
  String get title => _title;
  String get body => _body;
}
