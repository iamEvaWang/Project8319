import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsletterModel{
    final String? id;
    final String? author;
    final String? name;
    final String? image;
    final Timestamp? schedule;
    final String? date;
    final String? description;
    final String? webUrl;
    final List<String>? tags;
    bool isBookmark= false;

    NewsletterModel({
      this.id,
      this.author,
      this.name,
      this.image,
      this.schedule,
      this.date,
      this.description,
      this.webUrl,
      this.tags,});

    factory NewsletterModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot){
      final data = snapshot.data();
      return NewsletterModel(
        id:data?['id'],
        author:data?['author'],
        name:data?['newsletter_name'],
        image:data?['newsletter_image'],
        schedule:data?['publish_schedule'],
        date:data?['publish_date'],
        description:data?['newsletter_description'],
        webUrl:data?['website_url'],
        tags:data?['tags'] is Iterable? List.from(data?['tags']) : null,
      );
    }

    Map<String, dynamic> toFirestore(){
      return {};
    }

}