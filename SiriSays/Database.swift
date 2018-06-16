//
//  database.swift
//  sirisays
//
//  Created by Jie on 8/18/15.
//  Copyright © 2015 Jie. All rights reserved.
//

import Foundation

class Database {
    // get the full path to the Documents folder
    static func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) 
        return paths[0]
    }
    // get the full path to file of project
    static func dataFilePath(_ schema: String) -> String {
        return "\(Database.documentsDirectory())/\(schema)"
    }
    static func save(_ arrayOfObjects: [AnyObject], toSchema: String, forKey: String) {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(arrayOfObjects, forKey: "\(forKey)")
        archiver.finishEncoding()
        data.write(toFile: Database.dataFilePath(toSchema), atomically: true)
    }
}

class Phrase: NSObject, NSCoding {
    static var key: String = "Book"
    static var schema: String = "theList"
    var objective: String
    var createdAt: Date
    // use this init for creating a new Task
    init(obj: String) {
        objective = obj
        createdAt = Date()
    }
    // MARK: - NSCoding protocol
    // used for encoding (saving) objects
    func encode(with aCoder: NSCoder) {
        aCoder.encode(objective, forKey: "objective")
        aCoder.encode(createdAt, forKey: "createdAt")
    }
    // used for decoding (loading) objects
    required init?(coder aDecoder: NSCoder) {
        objective = aDecoder.decodeObject(forKey: "objective") as! String
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as! Date
        super.init()
    }
    // MARK: - Queries
    static func all() -> [Phrase] {
        var Book = [Phrase]()
        let path = Database.dataFilePath("theList")
        if FileManager.default.fileExists(atPath: path) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                Book = unarchiver.decodeObject(forKey: Phrase.key) as! [Phrase]
                unarchiver.finishDecoding()
            }
        }
        return Book
    }
    func save() {
        var BookFromStorage = Phrase.all()
        var exists = false
        for i in 0 ..< BookFromStorage.count {
            if BookFromStorage[i].createdAt == self.createdAt {
                BookFromStorage[i] = self
                exists = true
            }
        }
        if !exists {
            BookFromStorage.append(self)
        }
        Database.save(BookFromStorage, toSchema: Phrase.schema, forKey: Phrase.key)
    }
    func destroy() {
        var bookFromStorage = Phrase.all()
        for i in 0 ..< bookFromStorage.count {
            if bookFromStorage[i].createdAt == self.createdAt {
                bookFromStorage.remove(at: i)
            }
        }
        Database.save(bookFromStorage, toSchema: Phrase.schema, forKey: Phrase.key)
    }
}
