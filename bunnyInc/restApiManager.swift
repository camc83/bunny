//
//  restApiManager.swift
//  bunnyInc
//
//  Created by Christian Ernesto Chavarría Méndez on 06/10/18.
//  Copyright © 2018 Christian Ernesto Chavarría Méndez. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON) -> Void

class restApiManager: NSObject{
    static let sharedInstance = restApiManager()
    let baseURL = trAPIURL
    let transform = ""
    var isTransform = true
    
    func getData(option: String, onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL + option
        /*if(option.starts(with: "CAT_RECIBO") ){
         isTransform = false
         }*/
        makeHTTPGetRequest(path: route, onCompletion: { json in
            onCompletion(json as JSON)
        })
    }
    
    func setData(option: String, query: [String: AnyObject], method: String, onCompletion: @escaping (JSON) -> Void){
        let route = baseURL + option
        makeHTTPPostRequest(path: route, body: query, method: method, onCompletion: { json in
            //parse NSData to JSON
            //let json:JSON = JSON(data: data, options:NSJSONReadingOptions.MutableContainers, error:nil)
            
            //            let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            onCompletion(json as JSON)            //return results from request
        })
    }
    
    // MARK: Perform a GET Request
    private func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
        //let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        var url: URL
        
        if(isTransform){
            url = URL(string:path + transform)!
        }else{
            url = URL(string:path)!
        }
        
        //let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json)
            } else {
                onCompletion(JSON.null)
            }
        })
        task.resume()
    }
    
    // MARK: Perform a POST Request
    private func makeHTTPPostRequest(path: String, body: [String: AnyObject], method: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        // Set the method to POST
        if(isTransform){
            //request.setValue(trCookie, forKey: trHeader)
            request.setValue(trCookie, forHTTPHeaderField: trHeader)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        
        do {
            // Set the POST body for the request
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = jsonBody
            let session = URLSession.shared
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {
                (data, response, error) in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json)
                } else {
                    onCompletion(JSON.null)
                }
            })
            task.resume()
        } catch {
            // Create your personal error
            onCompletion(JSON.null)
        }
    }
}

