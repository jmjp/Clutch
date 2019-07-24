import 'package:clutch/src/clipers/retangle.dart';
import 'package:clutch/src/models/ranking.dart';
import 'package:clutch/src/pages/PlayerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  final Ranking player;
  const PlayerCard({Key key, this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Text(player.name,style: TextStyle(fontWeight: FontWeight.w700),),
            Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue,Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.5,0.5]
                      )
                    ),
                    height: 86,
                    width: 100,
                  ),
                  clipper: RetangleCustomClipper(),
                ),
                Center(
                  child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  backgroundImage: NetworkImage('https://static.hltv.org/images/playerprofile/thumb/${player.id}/800.jpeg?v=20'),
                  ),
                )
              ],
            )
          ],
        ),
        onTap: (){
          Navigator.push(context, CupertinoPageRoute(
            builder: (_) => PlayerPage(player: player,)
          ));
        },
      ),
      height: 100,
      width: 100,
      margin: EdgeInsets.only(top: 2,left: 5,right: 5,bottom: 2),
      decoration:BoxDecoration(
          color: Colors.white,
          border: const Border(
          top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
          bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
           ),
      ),
    );
  }
}