//
//  Article.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/16.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   var article = try? newJSONDecoder().decode(Article.self, from: jsonData)

import Foundation
import ObjectMapper

class ArticleModel: Mappable {
    var curPage: Int?
    var datas: [Article]?
    var offset: Int?
    var over: Bool = false
    var pageCount: Int?
    var size: Int?
    var total: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        curPage <- map["curPage"]
        datas <- map["datas"]
        offset <- map["offset"]
        over <- map["over"]
        pageCount <- map["pageCount"]
        size <- map["size"]
        total <- map["total"]
    }
}

// MARK: - Article
class Article: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        apkLink <- map["apkLink"]
        audit <- map["audit"]
        author <- map["author"]
        canEdit <- map["canEdit"]
        chapterID <- map["chapterID"]
        chapterName <- map["chapterName"]
        collect <- map["collect"]
        courseID <- map["courseID"]
        desc <- map["desc"]
        descMd <- map["descMd"]
        envelopePic <- map["envelopePic"]
        fresh <- map["fresh"]
        host <- map["host"]
        id <- map["id"]
        link <- map["link"]
        niceDate <- map["niceDate"]
        niceShareDate <- map["niceShareDate"]
        origin <- map["origin"]
        articlePrefix <- map["articlePrefix"]
        projectLink <- map["projectLink"]
        publishTime <- map["publishTime"]
        realSuperChapterID <- map["realSuperChapterID"]
        selfVisible <- map["selfVisible"]
        shareDate <- map["shareDate"]
        shareUser <- map["shareUser"]
        superChapterID <- map["superChapterID"]
        superChapterName <- map["superChapterName"]
        tags  <- map["tags"]
        title <- map["title"]
        type <- map["type"]
        userID <- map["userID"]
        visible <- map["visible"]
        zan <- map["zan"]
    }
    
    var apkLink: String?
    var audit: Int?
    var author: String?
    var canEdit: Bool?
    var chapterID: Int?
    var chapterName: String?
    var collect: Bool?
    var courseID: Int?
    var desc: String?
    var descMd: String?
    var envelopePic: String?
    /// 是否为新的
    var fresh: Bool = false
    var host: String?
    var id: Int?
    var link: String?
    var niceDate: String?
    var niceShareDate: String?
    var origin: String?
    var articlePrefix: String?
    var projectLink: String?
    var publishTime: Double?
    var realSuperChapterID: Int?
    var selfVisible: Int?
    var shareDate: Int?
    var shareUser: String?
    var superChapterID: Int?
    var superChapterName: String?
    var tags: [Tag]?
    var title: String = ""
    var type: Int?
    var userID: Int?
    var visible: Int?
    var zan: Int?
    
    /// 是否为置顶
    var isTop: Bool = false

}

// MARK: - Tag
class Tag: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
    }
    
    var name: String?
    var url: String?

}
