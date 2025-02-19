import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kovalskia/main/config.dart';
import 'package:kovalskia/main/main_function.dart';
import 'package:kovalskia/main/model/post_model.dart';
import 'package:kovalskia/main/model/user_model.dart';
import 'package:kovalskia/state/image/image_page.dart';
import 'package:kovalskia/state/post_detail/post_detail_page.dart';

class SeeProfileGetx extends GetxController {
  late User myUser = User.fromJson(C.box.read(Config.user));

  String email = Get.arguments;
  RxString userId = ''.obs;
  RxString myUserId = ''.obs;
  RxInt length = 0.obs;
  RxBool isUpdate = false.obs;
  RxBool loading = true.obs;
  RxList postList = [].obs;
  RxList follower = [].obs;
  Rx<User> user = User(
    username: '',
    email: '',
    password: '',
    profile: '',
    desc: '',
    follow: [],
    follower: [],
  ).obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void back() => Get.back(result: isUpdate.value);
  void postDetail(Post post) => Get.to(() => PostdetailPage(), arguments: post)?.then(
        (T) {
          if (T) isUpdate.value = true;
        },
      );
  void viewImage() => Get.to(() => ImagePage(), arguments: user.value.profile);

  void init() async {
    await Future.delayed(const Duration(microseconds: 1));
    C.loading();

    user.value = await getUserFirebase();
    user.refresh();

    follower.value = user.value.follower;
    follower.refresh();

    postList.value = await getDataPost();
    postList.refresh();

    QuerySnapshot<Map<String, dynamic>> q = await FirebaseFirestore.instance.collection('post').where('email', isEqualTo: email).get();

    length.value = q.size;
    Get.close(1);
    loading.value = false;
  }

  Future<User> getUserFirebase() async {
    await Future.delayed(const Duration(microseconds: 1));
    QuerySnapshot<Map<String, dynamic>> q = await FirebaseFirestore.instance.collection('user').where('email', isEqualTo: email).get();
    userId.value = q.docs.first.id;

    QuerySnapshot<Map<String, dynamic>> myQS = await FirebaseFirestore.instance.collection('user').where('email', isEqualTo: myUser.email).get();
    myUserId.value = myQS.docs.first.id;
    return User.fromJson(q.docs.first.data());
  }

  Future<List<Post>> getDataPost() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('post').where('email', isEqualTo: email).get();
    List<Post> posts = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String id = doc.id;
      data['id'] = id;
      Post post = Post.fromJson(data);
      return post;
    }).toList();
    posts.sort((a, b) => b.date.compareTo(a.date));
    return posts;
  }

  void doFollow() async {
    String myEmail = myUser.email;
    DocumentReference userDoc = FirebaseFirestore.instance.collection('user').doc(userId.value);
    DocumentReference myUserDoc = FirebaseFirestore.instance.collection('user').doc(myUserId.value);
    if (!follower.contains(myEmail)) {
      follower.add(myEmail);
      await userDoc.update({
        'follower': FieldValue.arrayUnion([myEmail])
      });
      await myUserDoc.update({
        'follow': FieldValue.arrayUnion([user.value.email])
      });
    } else {
      follower.remove(myEmail);
      await userDoc.update({
        'follower': FieldValue.arrayRemove([myEmail])
      });
      await myUserDoc.update({
        'follow': FieldValue.arrayRemove([user.value.email])
      });
    }
    isUpdate.value = true;
  }
}
