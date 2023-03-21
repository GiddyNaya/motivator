import 'dart:io';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:motivator/main.dart';
import 'package:motivator/utils/constants_util.dart';
import 'package:motivator/utils/helper_utils.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/share_item_model.dart';
import 'package:motivator/responsive.dart' as resp;

import '../../utils/widget_utils.dart';

class ShareWidget extends StatelessWidget {
  ShareWidget({required this.child, required this.data, Key? key})
      : super(key: key);

  Widget child;
  String data;
  CustomPopupMenuController _controller = CustomPopupMenuController();
  List<ShareItemModel> menuItems = [
    ShareItemModel(ShareOption.copy, 'copy.png'),
    ShareItemModel(ShareOption.facebook, 'facebook.png'),
    ShareItemModel(ShareOption.linkedin, 'linkedin.png'),
    ShareItemModel(ShareOption.twitter, 'twitter.png')
  ];

  @override
  Widget build(BuildContext context) {
    bool mobile = resp.Responsive.isMobile(context);
    return CustomPopupMenu(
      child: child,
      position: PreferredPosition.top,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(5),
          color: localStorage.isDarkModeOn ? Colors.black : Colors.grey,
          child: IntrinsicWidth(
            child: Row(
              children: menuItems
                  .map((item) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              onPressed: () async {
                                _controller.hideMenu();
                                await _share(item.title);
                              },
                              padding: const EdgeInsets.all(0),
                              icon: Image.asset(
                                "assets/images/${item.iconPath}",
                                width: 30,
                                color: localStorage.isDarkModeOn
                                    ? Colors.white
                                    : Colors.black,
                              )).paddingAll(5),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      // verticalMargin: -10,
      controller: _controller,
    );
  }

  Future<void> _share(String title) async {
    if (Platform.isIOS || Platform.isAndroid) {
      Share.share(data, subject: 'Share Quote');
      return;
    }
    switch (title) {
      case ShareOption.copy:
        await copyToClipboard(data);
        break;
      case ShareOption.twitter:
        await launchUrl(
            "https://twitter.com/intent/tweet?text=${Uri.encodeComponent(data)}&url=https%3A%2F%2F${Uri.base.origin}");
        break;
      case ShareOption.facebook:
        await launchUrl(
            "https://web.facebook.com/sharer/sharer.php?quote=${Uri.encodeComponent(data)}&url=https%3A%2F%2F${Uri.base.origin}");
        break;
      case ShareOption.linkedin:
        await launchUrl(
            "https://www.linkedin.com/sharing/share-offsite/?summary=${Uri.encodeComponent(data)}&url=https%3A%2F%2F${Uri.base.origin}");
        break;
      default:
    }
  }
}
