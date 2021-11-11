class PostComment {
  final int _id, _postId;
  final String _name, _email, _body;

  PostComment(
      {required int id,
      required int postId,
      required String name,
      required String email,
      required String body})
      : _id = id,
        _postId = postId,
        _name = name,
        _email = email,
        _body = body;

  factory PostComment.fromJson(Map<String, dynamic> map) {
    return PostComment(
      id: map['id'],
      postId: map['postId'],
      name: map['name'],
      email: map['email'],
      body: map['body'],
    );
  }

  int get id => _id;
  int get postId => _postId;
  String get name => _name;
  String get email => _email;
  String get body => _body;
}
