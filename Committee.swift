//
//  Committee.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//
import Foundation

class Committee {
    
    var name :String
    var positions: [Position]
    var id: NSUUID
    
    init(name: String, pos: [Position]){
        self.positions = pos
        self.name = name
        self.id = NSUUID()
    }
    
    func addToComitte(pos: Position) -> [Position]{
        positions.append(pos)
        return positions
    }
    

    func removeFromComitte(pos: Position) -> [Position]{
        var indexToRemove: Int = 0
        for var i=0;i<positions.count;i++ {
            if positions[i].name == pos.name {
                indexToRemove = i
                break
            }
        }
        positions.removeAtIndex(indexToRemove)
        return positions
    }
    
    func sortPositionsAlphabetically(){
        positions.sort({$0.name > $1.name})
    }
    
    func getPositions() -> [Position] {
        return positions
    }
    
       
    
}