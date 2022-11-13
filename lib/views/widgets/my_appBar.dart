import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../consts/constans.dart';
import '../../providers/theme_provider.dart';
import '../../providers/search_provider.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeNotifier, SearchProvider>(
      builder: (context, themeNotifier, searchNotifier, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // change the Theme by connecting to ThemeProvider and call toggleTheme()
                IconButton(
                  onPressed: () {
                    themeNotifier.toggleTheme();
                  },
                  icon: Icon(
                    themeNotifier.darkTheme
                        ? Icons.wb_sunny_outlined
                        : Icons.nights_stay_outlined,
                    color: kAppBarElementsColor,
                  ),
                ),
                Text(
                  'Mentz',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: kAppBarElementsColor),
                ),

                // show about me Dialog

                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                                contentPadding:
                                    EdgeInsets.all(kDefaultPadding * 2),
                                title: Text(
                                  'Contact Info',
                                  textAlign: TextAlign.center,
                                ),
                                children: [
                                  Text(
                                    aboutMe,
                                  )
                                ],
                              ));
                    },
                    icon: Icon(
                      Icons.info_outline_rounded,
                      color: kAppBarElementsColor,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: themeNotifier.darkTheme ? kSearchBgDark : kSearchBgLight,
                borderRadius: BorderRadius.circular(kDefaultRadius),
              ),

              // search input textField
              child: Center(
                child: TextField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.search,
                  textCapitalization: TextCapitalization.sentences,
                  controller: searchNotifier.searchController,
                  style: TextStyle(color: kAppBarElementsColor),
                  onChanged: (String text) {
                    searchNotifier.onChange(text);
                  },
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.search, color: kAppBarElementsColor),
                    suffixIcon: IconButton(
                      icon:
                          const Icon(Icons.clear, color: kAppBarElementsColor),
                      onPressed: () {
                        searchNotifier.onChange('');
                        searchNotifier.clearController();
                      },
                    ),
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: kAppBarElementsColor),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
