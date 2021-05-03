//
//  Status.swift
//  CalTest
//
//  Created by Jamie McAllister on 08/01/2018.
//  Copyright © 2018 Jamie McAllister. All rights reserved.
//

import Foundation
import FirebaseFirestore


class Status{
    
    let id: String?
    var poster: Person?
    let message: String?
    let posted: String?
    var name: String?
    var link: String?
    var comments: [Comment]?
    var isAd: Bool? = false
    
    init(isAd: Bool){
        self.id = nil
        self.poster = nil
        self.posted = nil
        self.message = nil
        self.name = nil
        self.link = nil
        self.comments = nil
        self.isAd = isAd
    }
    
    init(document: QueryDocumentSnapshot){
        let d = document.data()
        
        id = document.documentID
        message = d["text"] as? String
        posted = d["posted"] as? String
        link = ""
        comments = getComments(from: document)
        isAd = false
        getPerson(p: d["poster"] as! String)
        
    }
    
    func getPerson(p: String){
        let cal = CalendarHandler()
        cal.getperson(forUser: p, completion: {(person) in
            
            self.poster = person
            
        })
    }
    
    func getComments(from: QueryDocumentSnapshot) -> [Comment]{
        fatalError("getDocuments not yet implemented")
    }
    
}

struct Comment: Decodable{
    let id: String
    let poster: String
    let message: String
   // let posted: String
}
