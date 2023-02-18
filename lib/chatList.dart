import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat.dart';

class ChatListType{
  String? name;
  String? id;
  Timestamp last=Timestamp.now();

  ChatListType({name, id, last}){
    this.name = name;
    this.id = id;
    this.last = last;
  }
}

class ChatTile extends StatelessWidget {
  final String? name;
  final String? id;
  final Timestamp? last;
  final String? myId;
  const ChatTile({Key? key,required this.name, required this.id, required this.last, required this.myId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("$name"),
      trailing: Text("${last?.toDate()}"),
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
                builder: (context)=>Chat(id: id,myId: myId)
            ));
      },
    );
  }
}

class ChatList extends StatelessWidget {
  final String? myId;
  ChatList({Key? key,required this.myId}) : super(key: key);
  var firebaseStream = FirebaseFirestore.instance.collection("user").orderBy('last_message', descending: false).snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: firebaseStream,
          builder:(ctx, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final int? len = snapshot.data?.docs.length;
            if (len!=null) {
              var docs = snapshot.data!.docs;
              List<ChatListType> chatList = docs.map((e) {
                var data = e.data();
                  return ChatListType(name: data['name'],
                      id: data['id'],
                      last: data['last_message']);
              }).toList();
              chatList = chatList.where((element) => element.id!=myId).toList();
              chatList.sort((a,b){
                var x =  a.last.compareTo(b.last);
                return x==1?0:1;
              });
              int len2 = chatList.length;
              return ListView.builder(
                  itemCount: len2,
                  itemBuilder: (ctx, index) {
                    var data = chatList[index];
                    return ChatTile(
                        name: data.name, id: data.id, last: data.last, myId: myId,);
                  });
            }
            else{
              return const Center(child: Text("Null Returned"));
            }
          }),

    );
  }
}
