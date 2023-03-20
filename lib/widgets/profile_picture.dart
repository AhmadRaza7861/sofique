import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sofiqe/provider/account_provider.dart';

import '../utils/api/user_account_api.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  Future<File> getProfilePicture() async {
    var dir = (await getExternalStorageDirectory());
    File file = File(join(dir!.path, 'front_facing.jpg'));
    return file;
  }

  Future getProfilePictureFromServer(var customId) async {
    try {
      var result = await sfAPIGetUserSelfie(customId);
      log('==== selfie result is :: $result ===');
      if (result != null) {
        return result == "Selfie has not been uploaded" ? null : result;
      } else {
        log('==== get selfie response result is null :: $result');
        return null;
      }
    } catch (e) {
      log('==== Error while getting image =====');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!Provider.of<AccountProvider>(context, listen: false).isLoggedIn) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(size.height * 0.1)),
        child: Container(
            color: Colors.white,
            height: size.height * 0.08,
            width: size.height * 0.08,
            child: Center(
                child: Text(
              'Not logged in',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black,
                    fontSize: 10,
                  ),
            ))),
      );
    }
    return FutureBuilder(
        future: getProfilePictureFromServer(
            Provider.of<AccountProvider>(context).customerId),
        // future: getProfilePicture(),
        builder: (BuildContext _, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(size.height * 0.1)),
              child: Container(
                  color: Colors.white,
                  height: size.height * 0.08,
                  width: size.height * 0.08,
                  child: Center(
                      child: SpinKitFadingCircle(
                    size: 40,
                    color: Colors.black,
                  ))),
            );
          }
          return snapshot.data != null
              ? ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.height * 0.1)),
                  child: Container(
                    color: Colors.white,
                    height: size.height * 0.08,
                    width: size.height * 0.08,
                    child: CachedNetworkImage(
                      imageUrl: '${snapshot.data}',
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Colors.black,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    // child: Image.network('${snapshot.data}'),
                  ),
                )
              : ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.height * 0.1)),
                  child: Container(
                      color: Colors.white,
                      height: size.height * 0.08,
                      width: size.height * 0.08,
                      child: Center(
                          child: Text(
                        'No Image',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                              fontSize: 11,
                            ),
                      ))),
                );

          //
          // if (snapshot.data != null) {
          //   return ClipRRect(
          //     borderRadius:
          //         BorderRadius.all(Radius.circular(size.height * 0.1)),
          //     child: Container(
          //       color: Colors.white,
          //       height: size.height * 0.1,
          //       width: size.height * 0.1,
          //       child: Image.network('${snapshot.data}'),
          //       // Center(
          //       //     child: Text(
          //       //       'No Image',
          //       //       style: Theme.of(context).textTheme.bodyText1!.copyWith(
          //       //         color: Colors.black,
          //       //         fontSize: 12,
          //       //       ),
          //       //     ))
          //     ),
          //   );
          //   // File file = snapshot.data as File;
          //   // if (!file.existsSync()) {
          //   //   return ClipRRect(
          //   //     borderRadius:
          //   //         BorderRadius.all(Radius.circular(size.height * 0.1)),
          //   //     child: Container(
          //   //         color: Colors.white,
          //   //         height: size.height * 0.1,
          //   //         width: size.height * 0.1,
          //   //         child: Center(
          //   //             child: Text(
          //   //           'No Image',
          //   //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
          //   //                 color: Colors.black,
          //   //                 fontSize: 12,
          //   //               ),
          //   //         ))),
          //   //   );
          //   // }
          //   return ClipRRect(
          //     borderRadius:
          //         BorderRadius.all(Radius.circular(size.height * 0.1)),
          //     child: Container(
          //       height: size.height * 0.1,
          //       width: size.height * 0.1,
          //       child: Image.file(
          //         snapshot.data as File,
          //         fit: BoxFit.cover,
          //         height: size.height * 0.09,
          //         width: size.height * 0.09,
          //       ),
          //     ),
          //   );
          // } else {
          //   return Container();
          // }
        });
  }
}