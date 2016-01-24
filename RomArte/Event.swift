//
//  Event.swift
//  RomArte
//
//  Created by Claudio Segoloni on 05/01/16.
//  Copyright © 2016 RomArte. All rights reserved.
//

import UIKit

class Event: NSObject, NSCoding {
    
    // MARK: Properties
    var title: String
    var image: UIImage?
    var date: String
    var price: String
    var desc: String
    var rating: Int
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("events")
    
    // MARK: Types
    
    struct PropertyKey {
        static let titleKey = "title"
        static let imageKey = "image"
        static let dateKey = "date"
        static let priceKey = "price"
        static let descKey = "desc"
        static let ratingKey = "rating"
    }
    
    // MARK: Initialization
    
    init?(title: String, image: UIImage?, date: String, price: String, desc: String, rating: Int) {
        self.title = title
        self.image = image
        self.date = date
        self.price = price
        self.desc = desc
        self.rating = rating
        
        super.init()
        
        if title.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(image, forKey: PropertyKey.imageKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(price, forKey: PropertyKey.priceKey)
        aCoder.encodeObject(desc, forKey: PropertyKey.descKey)
        aCoder.encodeObject(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        let image = aDecoder.decodeObjectForKey(PropertyKey.imageKey) as? UIImage
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! String
        let price = aDecoder.decodeObjectForKey(PropertyKey.priceKey) as! String
        let desc = aDecoder.decodeObjectForKey(PropertyKey.descKey) as! String
        let rating = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! Int
        
        self.init(title: title, image: image, date: date, price: price, desc: desc, rating: rating)
    }
    
}
