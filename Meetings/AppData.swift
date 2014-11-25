//
//  AppData.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import Foundation

enum state {
    case HOMEPAGE, NEWCOMMITTEE, EDITCOMMITTEE
}


class AppData {
    var firstLaunch = true
    var positions: [Position] = []
    var committees: [Committee] = []
    
    var positionIndex = 0
    var positionId = 0
    var committeeIndex = 0
    
    var pickerPositions: [Position] = []
    
    var tempParticipants: [Position] = []
    var tempCommitteeName = ""
    var startedEditingCommittee = false
    
    var currentCommittee = 0
    
    var currentState = state.HOMEPAGE
    
    init(){
        
    }
    func getPosition(id: NSUUID) -> Position? {
        for(index, p) in enumerate(positions){
            if positions[index].id == id {
                return positions[index]
            }
        }
        return nil
    }
    func refreshCommittees(){
        for c in committees {
            for (index,p) in enumerate(c.positions) {
                if !containsPosition(positions, p){
                    c.positions.removeAtIndex(index)
                } else {
                    
                }
            }
        }
        //UPDATE ALL POSITIONS
        for(var i=0;i<committees.count;i++){
            for(var k=0;k < committees[i].positions.count; k++){
                for(var j=0;j<positions.count;j++){
                    if committees[i].positions[k].id == positions[j].id {
                        println("equal")
                        committees[i].positions[k] = positions[j]
                    }
                }
            }
        }
    }

    func addPosition(p: Position){
        positions.append(p)
        positions.sort({$0.name < $1.name})
    }
    
    func addCommittee(c: Committee){
        committees.append(c)
        committees.sort({$0.name < $1.name})
    }
    
    func removePosition(p: Position){
        for (index, element) in enumerate(positions){
            if(positions[index].name == p.name) {
                positions.removeAtIndex(index)
                break
            }
        }
    }
    func sortPickerPositions(){
        pickerPositions.sort({ $0.name < $1.name })
    }
    func removePosition(i: Int){
        positions.removeAtIndex(i)
    }
    func removeCommittee(i: Int){
        committees.removeAtIndex(i)
    }
    
    func clearTemp(){
        tempParticipants = []
        tempCommitteeName = ""
        startedEditingCommittee = false
        pickerPositions = []

    }

    
    func getRemainingPositions(c: Committee) -> [Position] {
        var result: [Position] = [Position]()
        for(var i=0;i<positions.count;i++){
            println(i)
            if !containsPosition(c.positions, positions[i]){
                result.append(positions[i])
            }
        }
        return result
    }
}