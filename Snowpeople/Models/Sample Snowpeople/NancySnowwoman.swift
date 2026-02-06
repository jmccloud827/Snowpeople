//
//  NancySnowwoman.swift
//
//  Created by Nancy Brinker on 2/06/26.
//

import SwiftUI

@MainActor extension SnowpersonModel {
    static let nancy: SnowpersonModel = {
        let model = SnowpersonModel()
        model.name = "Nancy"
        
        let middleBall = PartModel(partToCopy: .circle)
        middleBall.size.width = 100
        middleBall.size.height = 100
        middleBall.offset.width = 32
        middleBall.offset.height = 132
        model.parts.append(middleBall)
        
        let topBall = PartModel(partToCopy: .circle)
        topBall.size.width = 72
        topBall.size.height = 72
        topBall.offset.width = 35
        topBall.offset.height = 56
        model.parts.append(topBall)
        
        let rightArm = PartModel(partToCopy: .arm1)
        rightArm.size.width = 195
        rightArm.size.height = 112
        rightArm.offset.width = 114
        rightArm.offset.height = 85
        rightArm.rotation = .radians(0.9625534396870592)
        model.parts.append(rightArm)
        
        let bottomBall = PartModel(partToCopy: .circle)
        bottomBall.size.width = 127
        bottomBall.size.height = 127
        bottomBall.offset.width = 30
        bottomBall.offset.height = 230
        model.parts.append(bottomBall)
        
        let leftArm = PartModel(partToCopy: .arm1)
        leftArm.size.width = 195
        leftArm.size.height = 112
        leftArm.offset.width = -45
        leftArm.offset.height = 76
        leftArm.rotation = .radians(-0.8489647818676488)
        leftArm.isFlippedOnYAxis = true
        model.parts.append(leftArm)
        
        let face = PartModel(partToCopy: .face8)
        face.size.width = 44
        face.size.height = 44
        face.offset.width = 36
        face.offset.height = 57
        face.rotation = .radians(-0.05885801733386298)
        model.parts.append(face)
        
        let hat = PartModel(partToCopy: .hat2)
        hat.size.width = 100
        hat.size.height = 100
        hat.offset.width = 29
        hat.offset.height = 13
        model.parts.append(hat)
        
        let tux = PartModel(partToCopy: .neckwear8)
        tux.size.width = 110
        tux.size.height = 110
        tux.offset.width = 35
        tux.offset.height = 133
        tux.rotation = .radians(-0.003655269238572456)
        model.parts.append(tux)
        
        let leftMitten = PartModel(partToCopy: .mitten2)
        leftMitten.size.width = 79
        leftMitten.size.height = 99
        leftMitten.offset.width = -69
        leftMitten.offset.height = 48
        leftMitten.rotation = .radians(-0.2228351798071118)
        model.parts.append(leftMitten)
        
        let rightMitten = PartModel(partToCopy: .mitten2)
        rightMitten.size.width = 75
        rightMitten.size.height = 94
        rightMitten.offset.width = 133
        rightMitten.offset.height = 68
        rightMitten.rotation = .radians(0.34424148158615736)
        rightMitten.isFlippedOnYAxis = true
        model.parts.append(rightMitten)
        
        return model
    }()
}

#Preview {
    NavigationStack {
        Snowperson(snowperson: .nancy)
    }
}
