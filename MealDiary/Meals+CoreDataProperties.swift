//
//  Meals+CoreDataProperties.swift
//  MealDiary
//
//  Created by admin on 11/09/16.
//  Copyright © 2016 Stefan Papst. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Meals {

    @NSManaged var meal_description: String?
    @NSManaged var meal_image: NSData?
    @NSManaged var meal_title: String?
    @NSManaged var meal_rating: NSDecimalNumber?

}
