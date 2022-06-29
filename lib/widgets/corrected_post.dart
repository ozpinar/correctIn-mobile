// ignore_for_file: unused_local_variable, prefer_const_declarations, unused_element, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CorrectedPost extends StatefulWidget {
  final Map correctedPost;
  const CorrectedPost({Key? key, required this.correctedPost})
      : super(key: key);

  @override
  State<CorrectedPost> createState() => _CorrectedPostState();
}

class _CorrectedPostState extends State<CorrectedPost> {
  @override
  Widget build(BuildContext context) {
    final text1 = widget.correctedPost['oldPost']['postBody'] ?? "";
    final text2 = widget.correctedPost['postBody'] ?? "";

    final text1Words = text1.split(" ").asMap().entries.map((entry) {
          int idx = entry.key;
          String word = entry.value;
          return {
            'id': idx,
            'word': word,
          };
        }).toList() ??
        [];

    final text2Words = text2.split(" ").asMap().entries.map((entry) {
          int idx = entry.key;
          String word = entry.value;
          return {
            'id': idx,
            'word': word,
          };
        }).toList() ??
        [];

    bool wordIsInOriginal(word) {
      return text1Words.indexWhere((text1Word) =>
              text1Word['word'].toString().toLowerCase() ==
              word['word'].toString().toLowerCase()) >
          -1;
    }

    bool wordIsInCorrected(word) {
      return text2Words.indexWhere((text2Word) =>
              text2Word['word'].toString().toLowerCase() ==
              word['word'].toString().toLowerCase()) >
          -1;
    }

    bool isModifiedWithoutChangingLength() {
      return text1Words.length == text2Words.length;
    }

    bool samePlaceIsChanged(idx) {
      return isModifiedWithoutChangingLength() &&
          text1Words[idx]['word'] != text2Words[idx]['word'];
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              // ignore: prefer_const_constructors
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                ),
              ]),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Corrected by user @${widget.correctedPost['createdBy'] ?? ""}",
                style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Color.fromRGBO(89, 52, 79, 1)),
              ),
              Container(
                child: null,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: .5,
                      color: Color.fromRGBO(92, 134, 93, .4),
                    ),
                  ),
                ),
                margin: EdgeInsets.only(top: 5, bottom: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/profile.png"),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.correctedPost['oldPost']['user']
                                      ['firstName'] +
                                  " " +
                                  widget.correctedPost['oldPost']['user']
                                      ['lastName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              timeago.format(DateTime.parse(widget
                                      .correctedPost['oldPost']['createdAt'] ??
                                  "")),
                              style: TextStyle(
                                  color: Color.fromRGBO(83, 127, 85, 0.5)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Image.asset("assets/images/dots.png"),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ...text1Words
                            .map((word) => Container(
                                  padding: EdgeInsets.only(bottom: 25),
                                  child: Text(
                                    '${word['word'] ?? ""} ',
                                    style: TextStyle(
                                        decoration: !wordIsInCorrected(word) ||
                                                samePlaceIsChanged(word['id'])
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none),
                                  ),
                                ))
                            .toList()
                      ],
                    ),
                    Container(
                      child: null,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(92, 134, 93, .4)))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(92, 134, 93, .4),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Container(
                            child: Text(widget.correctedPost['comment'] ?? ""),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ...text2Words
                            .map(
                              (word) => Container(
                                child: Text('${word['word'] ?? ""} '),
                                color: !wordIsInOriginal(word) ||
                                        samePlaceIsChanged(word['id'])
                                    ? Color.fromRGBO(92, 134, 93, .4)
                                    : Colors.transparent,
                                margin: EdgeInsets.only(top: 25),
                              ),
                            )
                            .toList()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
