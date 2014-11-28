//
//  AppData.swift
//  Meetings
//
//  Created by FELIX DESCOTEAUX on 2014-11-23.
//  Copyright (c) 2014 FELIX DESCOTEAUX. All rights reserved.
//

import Foundation

//So we know which picker to choose
enum CommitteeAction {
    case NEWCOMMITTEE, EDITCOMMITTEE
}

enum ApplicationFlow {
    case FIRSTUSE, HASONEPOSITION, HASPOSITIONS, HASCOMMITTEE
}

enum Hint {
    case SHOW, HIDE
}

func containsPosition(array: [Position], pos: Position) -> Bool{
    for(var i = 0; i<array.count; i++){
        if(array[i].id == pos.id){
            return true
        }
    }
    return false
}


class AppData {
    
    var appFlow = ApplicationFlow.FIRSTUSE
    var currentCommitteeAction = CommitteeAction.NEWCOMMITTEE
    var hintPositions = Hint.HIDE
    var hintCommittees = Hint.HIDE
    var hintFirstPosition = Hint.SHOW
    var hintEditCommittee = Hint.HIDE
    var hintAddParticipants = Hint.SHOW
    
    var positions: [Position] = []
    var committees: [Committee] = []

    var positionId: NSUUID = NSUUID()
    var committeeId: NSUUID = NSUUID()
//    var committeeIndex = 0
    
    var pickerPositions: [Position] = []
    
    var tempParticipants: [Position] = []
    var tempCommitteeName = ""
    var startedEditingCommittee = false

    
    init(){
        
    }
    
    func getSalaryPerSecond() -> Float {
        var cc: Committee = self.getCurrentCommitte()!
        var totalSalaryPerSecond: Float = 0;
        for(var i=0;i<cc.positions.count;i++){
            var salaryPerSecondForPerson: Float = Float(cc.positions[i].salary)/365/24/60/60
            var salaryPerSecondForQuantity: Float = salaryPerSecondForPerson * Float(cc.positions[i].qty)
            totalSalaryPerSecond += salaryPerSecondForQuantity
        }
        return totalSalaryPerSecond
    }
    func getPosition(id: NSUUID) -> Position? {
        for(index, p) in enumerate(positions){
            if positions[index].id == id {
                return positions[index]
            }
        }
        return nil
    }
    
    func getCommitteesExceptCurrent() -> [Committee]{
        
        return committees.filter({$0.id != self.committeeId})
    }
    
    func getCommittee(id: NSUUID) -> Committee? {
        for(index, c) in enumerate(committees) {
            if committees[index].id == id {
                return committees[index]
            }
        }
        return nil
    }
    
    func refreshCommittees(){
        for c in committees {
            for (index,p) in enumerate(c.positions) {
                if !containsPosition(positions, p){
                    c.positions.removeAtIndex(index)
                }
            }
        }
        //UPDATE ALL POSITIONS
        for(var i=0;i<committees.count;i++){
            for(var k=0;k < committees[i].positions.count; k++){
                for(var j=0;j<positions.count;j++){
                    if committees[i].positions[k].id == positions[j].id {
                        var q = committees[i].positions[k].qty
                        committees[i].positions[k] = positions[j].copy()
                        committees[i].positions[k].qty = q
                    }
                }
            }
        }
    }

    func getCurrentCommitte() -> Committee? {
        for(var i=0;i<committees.count; i++){
            if committees[i].id == committeeId {
                return committees[i]
            }
        }
        return nil
    }
    
    func modifyCurrentCommittee(name: String, ps: [Position]){
        if let x = self.getCurrentCommitte()? {
            x.positions = ps
            x.name = name
            x.sortPositionsAlphabetically()
            self.clearTemp()
        }
    }

    func addPosition(p: Position){
        positions.append(p)
        positions.sort({$0.name < $1.name})
    }
    
    func addCommittee(c: Committee){
        committees.append(c)
        committees.sort({$0.name < $1.name})
        //we set current committee if no other committee is set
        self.committeeId = c.id
        self.clearTemp()
        println(committees[0].positions[0].qty)
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
        for(var i=0;i<positions.count;i++){
            self.positions[i].qty = 1
        }

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