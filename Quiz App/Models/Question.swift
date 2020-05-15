//
//  Question.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Question: Object {
    @objc dynamic var questionID: String = UUID().uuidString
    @objc dynamic var question: String = ""
    var options = List<String>()
    @objc dynamic var answer: Int = 0
    
    override class func primaryKey() -> String? {
        return "questionID"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.question = json["question"].stringValue
        switch json["answer"].stringValue {
        case "A":
            self.answer = 1
        case "B":
            self.answer = 2
        case "C":
            self.answer = 3
        case "D":
            self.answer = 4
        default:
            break
        }
        self.options.append(objectsIn: json["options"].arrayValue.map { $0.stringValue})
    }
    
    func save() {
        do {
            try RealmHelper.shared.realm.write {
                RealmHelper.shared.realm.add (self, update: .modified)
            }
        } catch {
            print("Error during Question save: \(error.localizedDescription)")
        }
    }
    
    static func getAll() -> [Question] {
        return RealmHelper.shared.realm.objects(Question.self).toArray()
    }
    
    static func getRandom(count: Int) -> [Question] {
        return Array(getAll().shuffled().prefix(count))
    }
}
