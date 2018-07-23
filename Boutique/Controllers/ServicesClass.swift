 //
//  ServicesClass.swift
 //  Boutique
 //
 //  Created by Shobhit Saxena on 04/07/18.
 //  Copyright © 2018 Shobhit Saxena. All rights reserved.
 //
import UIKit
import Alamofire

class ServicesClass: NSObject {
    
    var jobCardNavigationController: UINavigationController?
    class var sharedInstance :ServicesClass {
        struct Singleton {
            static let instance = ServicesClass()
        }
        return Singleton.instance
    }
    
    enum ResponseType: Int{
        case   kResponseTypeFail = 0
        case  kresponseTypeSuccess
    }
    
    typealias ServiceResponse = (ResponseType, AnyObject?) ->Void
    var dayRequestTask : URLSessionDataTask?
    
    func makePostRequest(path:String,params:String ,onCompletion:@escaping ServiceResponse)
    {
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string:path)! as URL)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = params.data(using: .utf8)
//        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        let task = session.dataTask(with: request as URLRequest) { result, response, error in
            guard result != nil && (response as? HTTPURLResponse)?.statusCode == 200 else {
                onCompletion(ResponseType.kResponseTypeFail, nil)
                return
            }
            var object:[String: AnyObject]
            do {
                object = try JSONSerialization.jsonObject(with: result!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary
                print(object)
                onCompletion(ResponseType.kresponseTypeSuccess, object as AnyObject?)
            } catch let error1 as NSError {
                onCompletion(ResponseType.kResponseTypeFail, nil)
                println_debug("error1 \(error1)")
            }
        }
        task.resume()
    }
    
    func makeGetRequest(path: String,onCompletion:@escaping ServiceResponse){
        let sessionConfig:URLSessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let url = NSURL(string:path)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        let task = session.dataTask(with: request as URLRequest) { result, response, error in
            guard result != nil else {
                println_debug("no data found: \(String(describing: error))")
                onCompletion(ResponseType.kResponseTypeFail, nil)
                return
            }
            var object:[String: AnyObject]
            do {
                object = try JSONSerialization.jsonObject(with: result!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary
                
                onCompletion(ResponseType.kresponseTypeSuccess, object as AnyObject?)
            } catch let error1 as NSError {
                onCompletion(ResponseType.kResponseTypeFail, nil)
                println_debug("error1 \(error1)")
            }
        }
        task.resume()
    }
 }



