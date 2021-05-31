import 'package:chate_com_firebase/screens/contacts_screan.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static String route = '/splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  Future<void> dynamicLink()async
  {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (linkData)async{

        print('link => ${linkData?.link}');
        print('link IOS => ${linkData?.ios}');
        print('link Android => ${linkData?.android}');
        print('link origin => ${linkData?.link?.origin}');
        print('link authority => ${linkData?.link?.authority}');
        print('link query => ${linkData?.link?.query}');
        print('link parametros em array => ${linkData?.link?.queryParameters}');
        print('link parametros em array=> ${linkData?.link?.queryParametersAll}');
        print('link path => ${linkData?.link?.path}');
        print('link query => ${linkData?.link?.scheme}');
        print('link query => ${linkData?.link?.userInfo}');
        print('link query ------------------------');

        var data = linkData;
        Uri deeplink = data?.link;
        print('Initial link: ${deeplink?.toString()}');
        var page = deeplink.queryParameters['page'];
        print('page: $page');

      },
      onError: (error)async{
        print('erro no link amigo!');
        print('code: '+error?.code);
        print(error?.message);
      }
    );


    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    Uri deeplink = data?.link;

    print('Initial link: ${deeplink?.toString()}');
    if(deeplink != null)
    {
      var page = deeplink.queryParameters['page'];
      print('Initial link path: ${deeplink?.path}');
      print('page: ${page}');

      Navigator.of(context).pushReplacementNamed(ContactsScrean.route);
      Navigator.of(context).pushNamed('/$page');
    }else{
      Navigator.of(context).pushReplacementNamed(ContactsScrean.route);
    }

  }

  @override
  void initState() {
    super.initState();
    dynamicLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ChatFirebase', style: TextStyle(fontSize: 20,color: Colors.white),),
            CircularProgressIndicator()
          ],
        ),),
      ),
    );
  }
}