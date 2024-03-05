//
//  HeadlineModel.swift
//  NewsApp

import Foundation

struct HeadlineModel: Codable {
    let status: String
    let totalResults : Int
    let articles: [Articles]?
}

struct Articles: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url:String?
    let imageURL:String?
    let publishedAt:String?
    let content:String?
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case articleDescription = "description"
        case url = "url"
        case imageURL = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
