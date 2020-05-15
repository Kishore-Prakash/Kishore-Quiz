//
//  Score.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import Foundation
import RealmSwift

class Score: Object {
    @objc dynamic var scoreID: String = UUID().uuidString
    @objc dynamic var score: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var age: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var question: String = ""
    @objc dynamic var scoredOn: Date = Date()
    
    override class func primaryKey() -> String? {
        return "scoreID"
    }

    func save() {
        do {
            try RealmHelper.shared.realm.write {
                RealmHelper.shared.realm.add (self, update: .modified)
            }
        } catch {
            print("Error during Score save: \(error.localizedDescription)")
        }
    }
    
    static func getAll() -> [Score] {
        return RealmHelper.shared.realm.objects(Score.self).sorted(byKeyPath: "score", ascending: false).toArray()
    }
}
