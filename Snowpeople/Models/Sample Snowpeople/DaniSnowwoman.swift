//
//  DaniSnowwoman.swift
//
//  Created by Dani Wagner on 1/8/26.
//

import SwiftUI

@MainActor extension SnowpersonModel {
    static let dani: SnowpersonModel = {
        let model = SnowpersonModel()
        model.name = "Dani"
        
        let bottomBall = PartModel(partToCopy: .circle)
        bottomBall.size.width = 200
        bottomBall.size.height = 200
        bottomBall.offset.width = 0
        bottomBall.offset.height = 265
        model.parts.append(bottomBall)
        
        let leftArm = PartModel(partToCopy: .arm6)
        leftArm.size.width = 125
        leftArm.size.height = 125
        leftArm.offset.width = -109
        leftArm.offset.height = 137
        model.parts.append(leftArm)
        
        let rightArm = PartModel(partToCopy: .arm6)
        rightArm.size.width = 125
        rightArm.size.height = 125
        rightArm.offset.width = 111
        rightArm.offset.height = 137
        rightArm.isFlippedOnYAxis = true
        model.parts.append(rightArm)
        
        let middleBall = PartModel(partToCopy: .circle)
        middleBall.size.width = 125
        middleBall.size.height = 125
        middleBall.offset.width = 0
        middleBall.offset.height = 168
        model.parts.append(middleBall)
        
        let topBall = PartModel(partToCopy: .circle)
        topBall.size.width = 90
        topBall.size.height = 90
        topBall.offset.width = 0
        topBall.offset.height = 87
        model.parts.append(topBall)
        
        let face = PartModel(partToCopy: .face5)
        face.size.width = 75
        face.size.height = 75
        face.offset.width = 0
        face.offset.height = 87
        model.parts.append(face)
        
        let hat = PartModel(partToCopy: .hat2)
        hat.size.width = 100
        hat.size.height = 100
        hat.offset.width = 4
        hat.offset.height = 36
        hat.isFlippedOnYAxis = true
        model.parts.append(hat)
        
        let leftMitten = PartModel(partToCopy: .mitten3)
        leftMitten.image?.layers[0].color = .black
        leftMitten.size.width = 65
        leftMitten.size.height = 65
        leftMitten.offset.width = -170
        leftMitten.offset.height = 116
        leftMitten.rotation = .degrees(-65)
        leftMitten.isFlippedOnYAxis = true
        model.parts.append(leftMitten)
        
        let rightMitten = PartModel(partToCopy: .mitten3)
        rightMitten.image?.layers[0].color = .black
        rightMitten.size.width = 65
        rightMitten.size.height = 65
        rightMitten.offset.width = 170
        rightMitten.offset.height = 116
        rightMitten.rotation = .degrees(65)
        model.parts.append(rightMitten)
        
        let scarf = PartModel(partToCopy: .neckwear4)
        scarf.image?.color = .black
        scarf.size.width = 130
        scarf.size.height = 130
        scarf.offset.width = 10
        scarf.offset.height = 162
        scarf.isFlippedOnYAxis = true
        model.parts.append(scarf)
        
        let button1 = PartModel(partToCopy: .button2)
        button1.image?.color = .black
        button1.size.width = 20
        button1.size.height = 20
        button1.offset.width = 0
        button1.offset.height = 151
        model.parts.append(button1)
        
        let button2 = PartModel(partToCopy: .button2)
        button2.image?.color = .black
        button2.size.width = 20
        button2.size.height = 20
        button2.offset.width = 0
        button2.offset.height = 176
        model.parts.append(button2)
        
        let button3 = PartModel(partToCopy: .button2)
        button3.image?.color = .black
        button3.size.width = 20
        button3.size.height = 20
        button3.offset.width = 0
        button3.offset.height = 201
        model.parts.append(button3)
        
        return model
    }()
}

#Preview {
    NavigationStack {
        Snowperson(snowperson: .dani)
    }
}
