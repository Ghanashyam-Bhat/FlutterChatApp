import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatText extends StatelessWidget {
  final String? content;
  final Timestamp time;
  final String? myId;
  final String? from;
  const ChatText({Key? key, required this.content, required this.time, required this.from, required this.myId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: myId==from?Alignment.topRight:Alignment.topLeft,
      height: 50,
      width: 50,
      child: Column(
        children: [
          Text("${time.toDate()}"),
          Text("$content")
        ],
      ),
    );
  }
}

class ChatType{
  String? from;
  String? to;
  String? message;
  Timestamp time = Timestamp.now();

  ChatType({from,to,message,time}){
  this.from = from;
  this.to = to;
  this.time = time;
  this.message = message;
 }
}

class Chat extends StatefulWidget {
  final String? id;
  final String? myId;
  const Chat({Key? key, required this.id, required this.myId}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String? id;
  String? myId;
  @override
  Widget build(BuildContext context) {

    final _controller = TextEditingController();
    String message = "";
    var firebaseStream = FirebaseFirestore.instance.collection("message").where("to",whereIn:["${widget.id}","${widget.myId}"]).snapshots();
    void sendMessage() async {
      print(message);
      await FirebaseFirestore.instance.collection('message').add({
        "message":message,
        "to":widget.id,
        "from":widget.myId,
        "time":Timestamp.now()
      });

      _controller.clear();
    }
    return Scaffold(
      body: StreamBuilder(
          stream:firebaseStream ,
          builder:(ctx, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var len = snapshot.data?.docs.length;
            if (len!=null)
              {
                var docs = snapshot.data!.docs;
                List<ChatType> chatList = docs.map((e) {
                  var data = e.data();
                  return ChatType(
                  from: data['from'],
                  to:data['to'],
                  message:data['message'],
                  time:data['time']);
                }).toList();
                chatList = chatList.where((element) => (element.to==widget.id || element.from==widget.id)).toList();
                chatList.sort((a,b){
                  var x =  a.time.compareTo(b.time);
                  return x==1?1:0;
                });
                int len2 = chatList.length;
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.75,
                      child: Expanded(
                        child: ListView.builder(
                        itemCount: len2,
                        itemBuilder: (ctx, index) {
                          // var doc = snapshot.data!.docs[index];
                          // var data = doc.data();
                          // print(data.toString());
                          return ChatText(content: chatList[index].message,time: chatList[index].time,from:chatList[index].from,myId:widget.myId);
                        }),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _controller,
                              onChanged: (value){
                            message= value;
                              }
                        )
                        ),
                        SizedBox(width: 20),
                        FloatingActionButton(onPressed:sendMessage)
                      ],
                    ),
                  ],
                );
              }//if statement
          else{
              return const Center(child: Text("Null Returned"));
            }
          }),
    ) ;

  }
}

