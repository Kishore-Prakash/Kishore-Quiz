//
//  RealmHelper.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    static let shared: RealmHelper = RealmHelper()
    let realm: Realm
    
    private init () {
        realm = try! Realm()
    }
    
}

extension Results {
    func toArray() -> [Element] {
        return self.map{$0}
    }
}

extension RealmSwift.List {
    func toArray() -> [Element] {
        return self.map{$0}
    }
}
