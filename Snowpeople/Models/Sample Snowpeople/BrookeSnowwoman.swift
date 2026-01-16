//
//  BrookeSnowwoman.swift
//
//  Created by Brooke Viviano on 1/9/26.
//

import SwiftUI

@MainActor extension SnowpersonModel {
    static let brooke: SnowpersonModel = {
        let model = SnowpersonModel()
        model.name = "Brooke"
        
        let bottomBall = PartModel(partToCopy: .circle)
        bottomBall.size.width = 150
        bottomBall.size.height = 150
        bottomBall.offset.width = 0
        bottomBall.offset.height = 290
        model.parts.append(bottomBall)
        
        let middleBall = PartModel(partToCopy: .circle)
        middleBall.size.width = 125
        middleBall.size.height = 125
        middleBall.offset.width = 0
        middleBall.offset.height = 182
        model.parts.append(middleBall)
        
        let topBall = PartModel(partToCopy: .circle)
        topBall.size.width = 100
        topBall.size.height = 100
        topBall.offset.width = 0
        topBall.offset.height = 94
        model.parts.append(topBall)
        
        let leftArm = PartModel(partToCopy: .arm3)
        leftArm.size.width = 150
        leftArm.size.height = 150
        leftArm.offset.width = -110
        leftArm.offset.height = 144
        leftArm.isFlippedOnYAxis = true
        model.parts.append(leftArm)
        
        let rightArm = PartModel(partToCopy: .arm3)
        rightArm.size.width = 150
        rightArm.size.height = 150
        rightArm.offset.width = 110
        rightArm.offset.height = 144
        model.parts.append(rightArm)
        
        let face = PartModel(partToCopy: .face5)
        face.size.width = 75
        face.size.height = 75
        face.offset.width = 0
        face.offset.height = 97
        model.parts.append(face)
        
        let hat = PartModel(partToCopy: .hat2)
        hat.size.width = 100
        hat.size.height = 100
        hat.offset.width = -4
        hat.offset.height = 36
        model.parts.append(hat)
        
        let leftMitten = PartModel(partToCopy: .mitten1)
        leftMitten.image?.color = .black
        leftMitten.image?.layers[0].color = .red
        leftMitten.size.width = 65
        leftMitten.size.height = 65
        leftMitten.offset.width = -170
        leftMitten.offset.height = 116
        leftMitten.rotation = .degrees(-65)
        model.parts.append(leftMitten)
        
        let rightMitten = PartModel(partToCopy: .mitten1)
        rightMitten.image?.color = .black
        rightMitten.image?.layers[0].color = .red
        rightMitten.size.width = 65
        rightMitten.size.height = 65
        rightMitten.offset.width = 170
        rightMitten.offset.height = 116
        rightMitten.rotation = .degrees(65)
        rightMitten.isFlippedOnYAxis = true
        model.parts.append(rightMitten)
        
        let scarf = PartModel(partToCopy: .neckwear3)
        scarf.image?.color = .black
        scarf.size.width = 250
        scarf.size.height = 250
        scarf.offset.width = -8
        scarf.offset.height = 170
        scarf.isFlippedOnYAxis = true
        model.parts.append(scarf)
        
        let headband = PartModel(partToCopy: .accessory4)
        headband.image?.color = .black
        headband.size.width = 160
        headband.size.height = 105
        headband.offset.width = 4
        headband.offset.height = 82
        headband.isFlippedOnYAxis = true
        model.parts.append(headband)
        
        let button1 = PartModel(partToCopy: .button5)
        button1.image?.color = .red
        button1.size.width = 20
        button1.size.height = 20
        button1.offset.width = 0
        button1.offset.height = 174
        model.parts.append(button1)
        
        let button2 = PartModel(partToCopy: .button5)
        button2.image?.color = .red
        button2.size.width = 20
        button2.size.height = 20
        button2.offset.width = 0
        button2.offset.height = 194
        model.parts.append(button2)
        
        let button3 = PartModel(partToCopy: .button5)
        button3.image?.color = .red
        button3.size.width = 20
        button3.size.height = 20
        button3.offset.width = 0
        button3.offset.height = 214
        model.parts.append(button3)
        
        return model
    }()
}

#Preview {
    NavigationStack {
        Snowperson(snowperson: .brooke)
    }
}
