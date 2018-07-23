//
//  QueueOperations.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//
import Foundation

protocol QueueOperationsProtocol {
    // Implement this method to hide and cancel the activity indicator part.
    func hideIndicator()
    
    // Implement this method to cancel all the request on the particular view controller. This is kinda mandatory.
    // Please do implement it, and clear the VC queue before pushing or popping the view controller
    func cancelAllOperations()
}

class QueueOperations {
    
    //delegate var for the QueueOperationsProtocol
    var queueOperationsDelegate : QueueOperationsProtocol?
    var queue = OperationQueue()
    /* 
     add the number of max webservices that will be implemented in that view controller,.
     This is also mandatory, do initialize this variable otherwise the indicator will never hide.
    */
    var webserviceCount = 0
    var completionCount = 0 {
        willSet {
            if newValue == webserviceCount {
                // hide indicator
                self.queueOperationsDelegate?.hideIndicator()
            }
        }
        didSet{
            if completionCount == -1{
                self.queueOperationsDelegate?.cancelAllOperations()
            }
        }
        
    }
}
