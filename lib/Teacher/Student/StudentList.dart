import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Student/HomePage/Home/MySimpleCircularProgressBar.dart';
import 'package:fourscore/main.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width(context) * 9 / 10,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: BackButton(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        // color: Colors.red,
                        width: width(context) * 3 / 10,
                        child: MyText(
                          text: "4Score",
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      Container(
                        height: 30,
                        width: width(context) * 2 / 10,
                        child: Spacer(
                          flex: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width(context) * 9 / 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://s3.getstickerpack.com/storage/uploads/sticker-pack/keqing/sticker_9.png?4996771f86fd38e818153e52edcc458f&d=200x200",
                          ),
                        ))),
                Spacer(
                  flex: 1,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          text: "Sandi Sulaiman Pratama",
                          color: PRIMARY_COLOR,
                          fontSize: 14),
                      MyText(
                        text: "2122119151",
                        color: INPUT,
                        fontSize: 12,
                      )
                    ],
                  ),
                ),
                Spacer(
                  flex: 9,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: width(context) * 9 / 10,
            alignment: Alignment.centerLeft,
            child: MyText(text: "Analystic", color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            height: 30,
          ),
          MySimpleCircularProgressBar(),
          SizedBox(
            height: 40,
          ),
          Container(
            width: width(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.remove,
                    color: PRIMARY_COLOR,
                    size: 40,
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.add,
                    color: PRIMARY_COLOR,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: width(context) * 9 / 10,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                MyText(
                  text: "Send Message",
                  color: Colors.white,
                  fontSize: 18,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width(context) * 9 / 10,
            height: 100,
            decoration: BoxDecoration(
                color: SECONDARY_COLOR,
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: SECONDARY_COLOR)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: SECONDARY_COLOR)),
                // contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                hintText: " Type something...",
                contentPadding: EdgeInsets.only(left: 20),
                hintStyle: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: INPUT),
              ),
              controller: message,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: width(context) * 9 / 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      side: (BorderSide(width: 1, color: Colors.black)),
                      backgroundColor: PRIMARY_COLOR,
                      primary: Colors.black,
                    ),
                    child: MyText(
                      text: "Send",
                      color: Colors.black,
                      fontSize: 16,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
