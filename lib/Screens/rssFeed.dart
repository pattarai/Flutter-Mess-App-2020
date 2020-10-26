import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Custom colors for my terminal theme.
import '../colors.dart';


import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RSSReader extends StatefulWidget {
  RSSReader() : super();

  // Setting title for the action bar.
  final String title = '<Hacker News\\> | Jobs Feed';

  @override
  RSSReaderState createState() => RSSReaderState();
}

class RSSReaderState extends State<RSSReader> {
  static const String FEED_URL = 'https://hnrss.org/jobs';

  
  RssFeed _feed;
  
  String _title; 

  
  static const String loadingMessage = 'Loading Feed...';
  static const String feedLoadErrorMessage = 'Error Loading Feed.';
  static const String feedOpenErrorMessage = 'Error Opening Feed.';

  
  GlobalKey<RefreshIndicatorState> _refreshKey;

 
  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  
  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }


  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMessage);
  }

  
  load() async {
    updateTitle(loadingMessage);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        
        updateTitle(feedLoadErrorMessage);
        return;
      }
      
      updateFeed(result);
      
      updateTitle("News of Jobs Feed");
    });
  }


  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {
      
    }
    return null;
  }


  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }

  
  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  
  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorHackerBackground,
        appBar: AppBar(
          title: Text(_title),
        ),
        body: body(),
      ),
    );
  }

  
  list() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: customBoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Link: " + _feed.link,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: colorHackerHeading),
                  ),
                  Text(
                    "Description: " + _feed.description,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: colorHackerHeading),
                  ),
                  Text(
                    "Docs: " + _feed.docs,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: colorHackerHeading),
                  ),
                  Text(
                    "Last Build Date: " + _feed.lastBuildDate,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: colorHackerHeading),
                  ),
                ],
              ),
            ),
          ),
        
          Expanded(
            flex: 3,
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: _feed.items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _feed.items[index];
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    decoration: customBoxDecoration(),
                    child: ListTile(
                      title: title(item.title),
                      subtitle: subtitle(item.pubDate.toString()),
                      trailing: rightIcon(),
                      contentPadding: EdgeInsets.all(5.0),
                      onTap: () => openFeed(item.link),
                    ),
                  );
                },
              ),
            ),
          ),
        ]);
  }

  
  title(title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: colorHackerHeading),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }


  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w300,
          color: colorHackerHeading),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  
  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: colorHackerBorder,
      size: 30.0,
    );
  }

  
  BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: colorHackerBorder, 
        width: 1.0,
      ),
    );
  }


}
