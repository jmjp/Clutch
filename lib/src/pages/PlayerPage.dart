import 'package:clutch/src/models/ranking.dart';
import 'package:clutch/src/widgets/CircularPercentage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/profilePlayer.dart';
import 'package:clutch/src/services/hltv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatelessWidget {
  final Ranking player;
  const PlayerPage({Key key,this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
               largeTitle: Text(player.name.toUpperCase())
          ),
         SliverList(
              delegate: SliverChildListDelegate(
                [
                  FutureBuilder<ProfilePlayer>(
                    future: getPlayerProfile(player.id),
                    builder: (context,snapshot){
                      if(snapshot.hasData){ 
                        return Column(
                          children: <Widget>[
                            Container(
                              child: CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(snapshot.data.image),
                              ),
                              margin: EdgeInsets.only(top: 5),
                            ),
                            Text("${snapshot.data.name}, ${snapshot.data.age} anos",style: TextStyle(fontSize: 24),),
                            Divider(
                              color: Colors.black,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(FontAwesome.home),
                                    Text("${snapshot.data.country.name}, ${snapshot.data.country.code}"),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(FontAwesome.steam_square),
                                    Container(
                                      child: Text(snapshot.data.ign.toString()),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(CupertinoIcons.group),
                                    Container(
                                      child: Text(snapshot.data.team.name),
                                    )
                                  ],
                                )
                              ],
                            ),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Text("Estatisticas"),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text("Rating"),
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child: CircleProgressBar(
                                        value: (snapshot.data.statistics.rating),
                                        foregroundColor: snapshot.data.statistics.rating > 1.0 ? Colors.blue : Colors.red,
                                        backgroundColor: Colors.grey,
                                      ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text("Headshots %"),
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child: CircleProgressBar(
                                        value: (snapshot.data.statistics.headshots / 100),
                                        foregroundColor: snapshot.data.statistics.headshots > 1.0 ? Colors.blue : Colors.red,
                                        backgroundColor: Colors.grey,
                                      ),
                                      )
                                    ],
                                  ),
                                   Column(
                                    children: <Widget>[
                                      Text("KAST"),
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child: CircleProgressBar(
                                        value: (snapshot.data.statistics.roundsContributed / 100),
                                        foregroundColor: snapshot.data.statistics.roundsContributed > 0.6 ? Colors.blue : Colors.red,
                                        backgroundColor: Colors.grey,
                                      ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text("Kill/round"),
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child: CircleProgressBar(
                                        value: (snapshot.data.statistics.killsPerRound),
                                        foregroundColor: snapshot.data.statistics.killsPerRound > 0.5 ? Colors.blue : Colors.red,
                                        backgroundColor: Colors.grey,
                                      ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text("Morte/round"),
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child: CircleProgressBar(
                                        value: (snapshot.data.statistics.deathsPerRound),
                                        foregroundColor: snapshot.data.statistics.headshots > 0.5 ? Colors.blue : Colors.red,
                                        backgroundColor: Colors.grey,
                                      ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Text("Redes Sociais"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        height: 50,
                                        width: 50,
                                        child: GestureDetector(
                                          child: Icon(FontAwesome.facebook,color: Colors.white,),
                                          onTap: (){
                                            if(snapshot.data.facebook != null){
                                              Navigator.push(context, CupertinoPageRoute(
                                              builder: (context){
                                                return CupertinoPageScaffold(
                                                  navigationBar: CupertinoNavigationBar(
                                                    middle: Text("Facebook"),
                                                  ),
                                                  child: SafeArea(
                                                    child: WebView(
                                                      javascriptMode: JavascriptMode.unrestricted,
                                                      initialUrl: snapshot.data.facebook,
                                                    ),
                                                  )
                                                );
                                              }
                                            ));
                                            }
                                          },
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        height: 50,
                                        width: 50,
                                        child: GestureDetector(
                                          child: Icon(FontAwesome.twitter,color: Colors.white,),
                                           onTap: (){
                                             if(snapshot.data.twitter != null){
                                                 Navigator.push(context, CupertinoPageRoute(
                                              builder: (context){
                                                return CupertinoPageScaffold(
                                                  navigationBar: CupertinoNavigationBar(
                                                    middle: Text("Twitter"),
                                                  ),
                                                  child: SafeArea(
                                                    child: WebView(
                                                      javascriptMode: JavascriptMode.unrestricted,
                                                      initialUrl: snapshot.data.twitter,
                                                    ),
                                                  )
                                                );
                                              }
                                            ));
                                             }
                                          },
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        height: 50,
                                        width: 50,
                                        child: GestureDetector(
                                          child: Icon(FontAwesome.twitch,color: Colors.white,),
                                           onTap: (){
                                            if(snapshot.data.twitch != null){
                                              Navigator.push(context, CupertinoPageRoute(
                                              builder: (context){
                                                return CupertinoPageScaffold(
                                                  navigationBar: CupertinoNavigationBar(
                                                    middle: Text("Twitch"),
                                                  ),
                                                  child: SafeArea(
                                                    child: WebView(
                                                      javascriptMode: JavascriptMode.disabled,
                                                      initialUrl: snapshot.data.twitch,
                                                      
                                                    ),
                                                  )
                                                );
                                              }
                                            ));
                                            }
                                          },
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 120,
                                    child: ListView.builder(
                                    itemCount: snapshot.data.achievements.length,
                                    itemBuilder: (context,int index){
                                        if(snapshot.data.achievements[index].place.index == 4){
                                          return Text("Campeão do ${snapshot.data.achievements[index].event.name}");
                                        }else if(snapshot.data.achievements[index].place.index == 2){
                                          return Text("Vice-Campeão do ${snapshot.data.achievements[index].event.name}");
                                        }else if(snapshot.data.achievements[index].place.index == 1){
                                          return Text("Terceira posição do ${snapshot.data.achievements[index].event.name}");
                                        }
                                        return null;
                                       
                                    },
                                  ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }else if(snapshot.hasError){
                        return Text(snapshot.error);
                      }
                      return CupertinoActivityIndicator();
                    },
                  )
                ],
              ),
          )
        ],
      )
    );
  }
}