//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Drew Boowee on 7/26/19.
//  Copyright © 2019 Drew Boowee. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Trip)
public class Trip: NSManagedObject
{
    
    convenience init?(title: String?, contents: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Trip.entity(), insertInto: managedContext)
        
        self.title = title
        self.contents = contents
    }


}
