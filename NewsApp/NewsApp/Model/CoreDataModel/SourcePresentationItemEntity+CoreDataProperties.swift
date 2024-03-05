//
//  SourcePresentationItemEntity+CoreDataProperties.swift
//  NewsApp

import Foundation
import CoreData


extension SourcePresentationItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourcePresentationItemEntity> {
        return NSFetchRequest<SourcePresentationItemEntity>(entityName: "SourcePresentationItemEntity")
    }
    @NSManaged public var sourceID: String
    @NSManaged public var sourceName: String
    @NSManaged public var isCheckBoxSelected: Bool
}

extension SourcePresentationItemEntity : Identifiable {}
