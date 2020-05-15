//
//  QAResponse.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import Foundation

enum Status {
    case success
    case failure
}

class QAResponse {
    
    var status: Status
    var message: String
    var data: Data? = nil
    
    init() {
        self.status = .failure
        self.message = String()
    }
    
    init(status: Status, message: String, data: Data?) {
        self.status = status
        self.message = message
        self.data = data
    }
}
