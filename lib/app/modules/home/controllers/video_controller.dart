import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tik_tok/app/modules/home/controllers/auth_controller.dart';
import 'package:tik_tok/app/modules/home/models/comment_model.dart';
import 'package:tik_tok/app/modules/home/models/post_model.dart';
import 'package:tik_tok/app/modules/home/widgets/dialogs/loading_dialog.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  AuthController ac = Get.find<AuthController>();
  final Rx<List<VideoModel>> _videoList = Rx<List<VideoModel>>([]);
  late Rx<User?> _user;
  List<VideoModel> get videoList => _videoList.value;
  User? get user => _user.value;
  final Rx<List<CommentModel>> _commentList = Rx<List<CommentModel>>([]);
  List<CommentModel> get commentList => _commentList.value;
  String _postId = '';

  @override
  void onInit() {
    _videoList.bindStream(FirebaseFirestore.instance
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<VideoModel> list = [];
      for (var element in query.docs) {
        list.add(VideoModel.fromSnap(element));
      }
      return list;
    }));
    super.onInit();
  }

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    showLoadingDialog(message: 'Posting Please Wait!');
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // get id
      var allDocs = await FirebaseFirestore.instance.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      VideoModel video = VideoModel(
        username: (userDoc.data()! as Map<String, dynamic>)['username'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePic'],
        thumbnail: thumbnail,
      );

      await FirebaseFirestore.instance
          .collection('videos')
          .doc('Video $len')
          .set(
            video.toJson(),
          );
      hideLoadingDialog();
      Get.back();
    } catch (e) {
      hideLoadingDialog();
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }

  likeVideo({required String id}) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('videos').doc(id).get();
    var uid = ac.user!.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await FirebaseFirestore.instance.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _commentList.bindStream(
      FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<CommentModel> retValue = [];
          for (var element in query.docs) {
            retValue.add(CommentModel.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  postComments({required String comments}) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(ac.user!.uid)
          .get();
      var allDocs = await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .get();
      int len = allDocs.docs.length;
      CommentModel comment = CommentModel(
        username: (userDoc.data()! as dynamic)['username'],
        comment: comments,
        likes: [],
        profilePhoto: (userDoc.data()! as dynamic)['profilePic'],
        uid: ac.user!.uid,
        id: 'Comment $len',
      );
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc('Comment $len')
          .set(
            comment.toJson(),
          );
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .get();
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .update({
        'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
      });
    } catch (e) {
      Get.snackbar(
        'Error While Commenting',
        e.toString(),
      );
    }
  }

  likeComment(String id) async {
    var uid = ac.user!.uid;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
