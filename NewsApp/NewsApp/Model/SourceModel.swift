//
//  SourceModel.swift
//  NewsApp

struct SourceModel: Codable {
    let status: String?
    let sources: [Sources]?
}

struct Sources: Codable {
    let id: String?
    let name : String?
    let description : String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}
