//
//  Utility.swift
//  GetMyParking
//
//  Created by Shobhit Saxena on 07/05/17.
//  Copyright © 2017 Shobhit Saxena. All rights reserved.
//

import UIKit

//utility class containing methods that we use exhaustively 
class Utility: NSObject {
    
    public static var shared = Utility()
    
    func returnJsonContents(filename : String, fileExtension : String) -> Any? {
        do {
            if let file = Bundle.main.url(forResource: filename, withExtension: fileExtension) {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    return object
                } else if let object = json as? [Any] {
                    // json is an array
                    return object
                } else {
                    print("JSON is invalid")
                    return nil
                    
                }
            } else {
                print("no file")
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func writeToFile(file : String, text : Data){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            //writing
            do {
                try text.write(to: path, options: [])
                return
            }
            catch {/* error handling here */
                print("could not write")
                return
            }
        }
    }
    
    func readJsonFile(file : String) -> Data?{
        if let path = Bundle.main.url(forResource: file, withExtension: "json") {
            
            //reading
            do {
                let text2 = try Data.init(contentsOf: path)
                return text2
            }
            catch {/* error handling here */
                return nil
            }
        }

        return nil
    
    }
}


extension Array{
    
//    func chunk(_ chunkSize: Int) -> [[Home]] {
//        return stride(from: 0, to: self.count, by: chunkSize).map({ (startIndex) -> [Home] in
//            let endIndex = (startIndex.advanced(by: chunkSize) > self.count) ? self.count-startIndex : chunkSize
//            return Array(self[startIndex..<startIndex.advanced(by: endIndex)]) as! [Home]
//        })
//    }
//    
//    func chunked(by distance: IndexDistance) -> [[Home]] {
//        let indicesSequence = stride(from: self.startIndex, to: self.endIndex, by: distance)
//        let array: [[Home]] = indicesSequence.map {
//            let rangeEndIndex = $0.advanced(by: distance) > self.endIndex ? self.endIndex : $0.advanced(by: distance)
//            //let rangeEndIndex = self.index($0, offsetBy: distance, limitedBy: self.endIndex) ?? self.endIndex // also works
//            return Array(self[$0 ..< rangeEndIndex]) as! [Home]
//        }
//        return array
//    }
}
