//
//  Entry+CoreDataClass.swift
//  Travelogue
//
//  Created by Drew Boowee on 7/26/19.
//  Copyright © 2019 Drew Boowee. All rights reserved.
//
//

import Foundation
import CoreData
import UIkit

@objc(Entry)
public class Entry: NSManagedObject {
    

    var modifiedDate: Date? {
        get {
            return date as Date?
        }
        set {
            date = newValue as NSDate?
        }
    }
    
    var imageModified: UIImage?
    {
        get
        {
            if let imageData = image as Data?
            {
                return UIImage(data: imageData)
            }
            else
            {
                return nil
            }
        }
        set
        {
            if let imageModified = newValue
            {
                image = convertImageToNSData(image: imageModified)
            }
        }
    }
    
    convenience init?(title: String?, contents: String?)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext
        else
        {
            return nil
        }
        
        self.init(entity: Entry.entity(), insertInto: managedContext)
        
        self.title = title
        self.contents = contents
        self.modifiedDate = date
        self.trip = trip
    }
    
    func update(title: String, content: String?, date: Date, image: UIImage?, trip: Trip) {
        self.title = title
        self.content = content
        self.modifiedDate = date
        self.trip = trip
        if let image = image {
            self.image = convertImageToNSData(image: image)
        }
    }
    
}
