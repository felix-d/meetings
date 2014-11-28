
//
//  Position.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-22.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import Foundation

class Position {
    var id: NSUUID
    var name: String
    var salary: Int
    var qty: Int
    
    init(name: String, salary: Int){
        self.name = name
        self.salary = salary
        self.qty = 1
        self.id = NSUUID()
    }
    init(name: String, salary: Int, quantity: Int, id: NSUUID){
        self.name = name
        self.salary = salary
        self.qty = quantity
        self.id = id
    }

    
    func copy() -> Position {
        return Position(name: self.name, salary: self.salary, quantity: self.qty, id: self.id)
    }
}