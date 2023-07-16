import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Teacher/Student/StudentList.dart';
import 'package:fourscore/main.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchBarSiswa = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: Container(
        child: Column(
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
              child: TextField(
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
                decoration: InputDecoration(
                  suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.search,
                        color: INPUT,
                        size: 30,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SECONDARY_COLOR)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SECONDARY_COLOR)),
                  // contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: SECONDARY_COLOR,
                  filled: true,
                  hintText: " Search",
                  contentPadding: EdgeInsets.only(left: 20),
                  hintStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: INPUT),
                ),
                controller: searchBarSiswa,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: width(context) * 9 / 10,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return StudentList();
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: width(context) * 9 / 10,
                      height: 80,
                      decoration: BoxDecoration(
                          color: SECONDARY_COLOR,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: ListTile(
                          title: MyText(
                              text: "Sandi Sulaiman Pratama",
                              color: PRIMARY_COLOR,
                              fontSize: 14),
                          subtitle: MyText(
                            text: "2122119151",
                            color: INPUT,
                            fontSize: 12,
                          ),
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                  "https://s3.getstickerpack.com/storage/uploads/sticker-pack/keqing/sticker_9.png?4996771f86fd38e818153e52edcc458f&d=200x200")),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
