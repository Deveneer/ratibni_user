import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/html_tag_remover.dart';
import 'package:ratibni_user/app/core/utils/loader.dart';
import '../controllers/contents_controller.dart';

class ContentsView extends GetView<ContentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          controller.contentType == '0'
              ? AppStrings.termsAndCondition
              : controller.contentType == '1'
                  ? AppStrings.aboutUs
                  : AppStrings.privacyPolicy,
          style: Get.textTheme.headline6.copyWith(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: controller.content.value == ErrorText.noDataFound
            ? Loader().showNoDataFound()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 100),
                  child: Obx(
                    () => Text(
                      HtmlTagRemover.removeHtmlTags(controller.content.value),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(.7),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
