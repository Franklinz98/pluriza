import 'package:get/get.dart';
import 'package:pluriza/domain/models/post.dart';

class PostController extends GetxController {
  final _posts = Rx<List<Post>>([]);
  final _filtered = RxBool(false);
  int _selected = -1;

  set newPosts(List<Post> posts) {
    _posts.value = posts;
  }

  void deleteAll() {
    if (_filtered.value) {
      _posts.value.removeWhere((post) => post.favorite);
      _posts.refresh();
    } else {
      _posts.value = [];
    }
  }

  void delete(int postId) {
    _posts.value.removeWhere((post) => post.id == postId);
    _posts.refresh();
  }

  void toggleFavorite() {
    Post post = posts.firstWhere((post) => post.id == _selected);
    post.favorite = !post.favorite;
    _posts.refresh();
  }

  void markAsRead() {
    posts.firstWhere((post) => post.id == _selected).read = true;
    _posts.refresh();
  }

  set filter(bool filterList) {
    _filtered.value = filterList;
  }

  set selected(int index) {
    _selected = index;
  }

  List<Post> get posts => _filtered.value
      ? _posts.value.where((post) => post.favorite).toList()
      : _posts.value;

  bool get filtered => _filtered.value;

  int get selectecId => _selected;

  Post get selectedPost {
    return posts.firstWhere((post) => post.id == _selected);
  }
}
