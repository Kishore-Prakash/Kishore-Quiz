//
//  WebServices.swift
//  Quiz App
//
//  Created by Kishore Prakash on 15/05/20.
//  Copyright © 2020 Kishore Prakash. All rights reserved.
//

import Foundation

class WebServices {
    static let shared: WebServices = WebServices()
    
    private init() {
    }
    
    func get(with url: String, completionHandler: @escaping (_ qaResponse: QAResponse) -> ()) {
        guard let url = URL(string: url) else {
            let osResponse = QAResponse(status: .failure, message: "Unsupported Format", data: nil)
            completionHandler(osResponse)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                let osResponse = QAResponse(status: .failure, message: error.localizedDescription, data: nil)
                completionHandler(osResponse)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    let osResponse = QAResponse()
                    osResponse.status = .failure
                    osResponse.message = "Error with the response, unexpected status code: \(String(describing: response))"
                    completionHandler(osResponse)
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            if let data = data {
                let osResponse = QAResponse(status: .success, message: "", data: data)
                completionHandler(osResponse)
            } else {
                let osResponse = QAResponse()
                osResponse.status = .failure
                osResponse.message = "Error with the response, unexpected status code: \(String(describing: response))"
                completionHandler(osResponse)
            }
            
        })
        task.resume()
    }
}
