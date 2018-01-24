//
//  Route.swift
//  TravelingSalesman
//
//  Created by Dennis Broekhuizen on 11-01-18.
//  Copyright © 2018 Dennis Broekhuizen. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Route {
    var name: String
    var date: String
    var startingPoint: String
    var destinations: [String]
    let ref: DatabaseReference?
    
    init(name: String, date: String, startingPoint: String, destinations: [String]) {
        self.name = name
        self.date = date
        self.startingPoint = startingPoint
        self.destinations = destinations
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        date = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        startingPoint = snapshotValue["startingPoint"] as! String
        destinations = snapshotValue["destinations"] as! [String]
        ref = snapshot.ref
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

struct CurrentRoute {
    var name: String
    var date: String
    var startingPoint: String
    var destinations: [String]
    let ref: DatabaseReference?
    
    init(name: String, date: String, startingPoint: String, destinations: [String]) {
        self.name = name
        self.date = date
        self.startingPoint = startingPoint
        self.destinations = destinations
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        date = snapshotValue["date"] as! String
        name = snapshotValue["name"] as! String
        startingPoint = snapshotValue["startingPoint"] as! String
        destinations = snapshotValue["destinations"] as! [String]
        ref = snapshot.ref
    }
}
