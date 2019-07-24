import 'package:clutch/src/models/gameEvents.dart';
import 'package:clutch/src/models/profilePlayer.dart';
import 'package:clutch/src/services/hltv.dart';
import 'package:clutch/src/widgets/playerCard.dart';
import '../models/ranking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).brightness == Brightness.light
              ? CupertinoColors.extraLightBackgroundGray
              : CupertinoColors.darkBackgroundGray,
        ),
        child: ListView(
          children: <Widget>[
             Padding(
               padding: EdgeInsets.only(left: 5),
               child: Text("Ranking global",style: TextStyle(fontWeight: FontWeight.w400),),
             ),
             Container(
                height: 110,
                child: FutureBuilder<List<Ranking>>(
                  future: playerRanking(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,int index){
                          return PlayerCard(player: snapshot.data[index]);
                        },
                      );
                    }else if(snapshot.hasError){
                      return Text("Error");
                    }
                    return CupertinoActivityIndicator();
                  },
                ),
           ),
           Padding(
               padding: EdgeInsets.only(left: 5,bottom: 2),
               child: Text("Campeonatos este mês",style: TextStyle(fontWeight: FontWeight.w400),),
            ),
           FutureBuilder<List<GameEvents>>(
             future: getGameEvents(DateTime.now().month),
             builder: (context,snapshot){
               if(snapshot.hasData){
                 return ListView.builder(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: snapshot.data[0].events.length,
                   itemBuilder: (context,int index){
                     if(snapshot.data[0].events[index].name.isNotEmpty){
                       return Container(
                         color: Colors.white,
                         margin: EdgeInsets.only(top: 2,bottom: 5),
                         child: Column(
                           children: <Widget>[
                             Stack(
                               children: <Widget>[
                                  Positioned(
                                    child:
                                    Container(
                                    child: Image(
                                    image: NetworkImage('https://i.pinimg.com/originals/e6/52/eb/e652ebea3f3b225adfda929602f9ef9a.jpg'),
                                    fit: BoxFit.cover,
                                    ),
                                  ),
                                  ),
                                  Center(
                                    child: Text(snapshot.data[0].events[index].name.toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: Colors.white),),
                                  )
                               ],
                             ),
                             Text("Premio: ${snapshot.data[0].events[index].prizePool}"),
                             Text("Equipes: ${snapshot.data[0].events[index].teams}"),
                             Text("Acaba em: ${DateTime.fromMillisecondsSinceEpoch(snapshot.data[0].events[index].dateEnd).day}/${DateTime.fromMillisecondsSinceEpoch(snapshot.data[0].events[index].dateEnd).month}/${DateTime.fromMillisecondsSinceEpoch(snapshot.data[0].events[index].dateEnd).year}")
                           ],
                         ),
                       );
                     }
                   },
                  );
               }else if(snapshot.hasError){
                 return Text(snapshot.error);
               }
               return CupertinoActivityIndicator();
             },
           )
          ],
        ),
      ),
    );
  }
}