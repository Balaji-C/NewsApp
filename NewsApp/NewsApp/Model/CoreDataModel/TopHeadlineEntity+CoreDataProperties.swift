//
//  TopHeadlineEntity+CoreDataProperties.swift
//  NewsApp

import Foundation
import CoreData


extension TopHeadlineEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopHeadlineEntity> {
        return NSFetchRequest<TopHeadlineEntity>(entityName: "TopHeadlineEntity")
    }
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var authorName: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var detailURL: String?
    @NSManaged public var isSelected: Bool
}

extension TopHeadlineEntity : Identifiable {}
