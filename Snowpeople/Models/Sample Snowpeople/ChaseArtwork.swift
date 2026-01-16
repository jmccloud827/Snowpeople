//
//  ChaseArtwork.swift
//
//  Created by Chase Wagner on 1/15/26.
//

import SwiftUI

@MainActor extension SnowpersonModel {
    static let chase: SnowpersonModel = {
        let model = SnowpersonModel()
        model.name = "Chase"
        
        let background = PartModel(partToCopy: .circle)
        background.size.width = 487
        background.size.height = 507
        background.offset.width = -11
        background.offset.height = 16
        background.shape?.color = .init(red: 0, green: 0.013763427734375, blue: 0.2725066542625427)
        model.parts.append(background)
        
        let backgroundArm = PartModel(partToCopy: .arm3)
        backgroundArm.size.width = 340
        backgroundArm.size.height = 340
        backgroundArm.offset.width = -125
        backgroundArm.offset.height = -71
        backgroundArm.image?.color = .black
        model.parts.append(backgroundArm)
        
        let moon = PartModel(partToCopy: .circle)
        moon.size.width = 128
        moon.size.height = 128
        moon.offset.width = -83
        moon.offset.height = -123
        moon.image?.color = .white
        model.parts.append(moon)
        
        let cliff1 = PartModel(partToCopy: .nose6)
        cliff1.size.width = 366
        cliff1.size.height = 366
        cliff1.offset.width = 51
        cliff1.offset.height = 76
        cliff1.rotation = .radians(3.7656031766975797)
        cliff1.image?.color = .init(red: 0.0039215087890625, green: 0.1137237474322319, blue: 0.34117114543914795)
        cliff1.image?.layers[0].color = .black
        model.parts.append(cliff1)
        
        let cliff2 = PartModel(partToCopy: .nose6)
        cliff2.size.width = 370
        cliff2.size.height = 370
        cliff2.offset.width = 23
        cliff2.offset.height = 99
        cliff2.rotation = .radians(3.7656031766975797)
        cliff2.image?.color = .init(red: 0.0039215087890625, green: 0.1137237474322319, blue: 0.34117114543914795)
        cliff2.image?.layers[0].color = .black
        model.parts.append(cliff2)
        
        let cliff3 = PartModel(partToCopy: .nose6)
        cliff3.size.width = 346
        cliff3.size.height = 346
        cliff3.offset.width = 9
        cliff3.offset.height = 132
        cliff3.rotation = .radians(3.7656031766975797)
        cliff3.image?.color = .init(red: 0.0039215087890625, green: 0.1137237474322319, blue: 0.34117114543914795)
        cliff3.image?.layers[0].color = .black
        model.parts.append(cliff3)
        
        let body = PartModel(partToCopy: .arm9)
        body.size.width = 96
        body.size.height = 96
        body.offset.width = 74
        body.offset.height = 42
        body.rotation = .radians(4.73543321569683)
        body.image?.color = .black
        model.parts.append(body)
        
        let head = PartModel(partToCopy: .circle)
        head.size.width = 66
        head.size.height = 42
        head.offset.width = 101
        head.offset.height = -26
        head.image?.color = .white
        model.parts.append(head)
        
        let leftArm = PartModel(partToCopy: .arm8)
        leftArm.size.width = 54
        leftArm.size.height = 54
        leftArm.offset.width = 55
        leftArm.offset.height = 16
        leftArm.rotation = .radians(0.4705640150420771)
        leftArm.image?.color = .white
        model.parts.append(leftArm)
        
        let rightArm = PartModel(partToCopy: .arm8)
        rightArm.size.width = 54
        rightArm.size.height = 54
        rightArm.offset.width = 104
        rightArm.offset.height = 9
        rightArm.rotation = .radians(-0.352770387826276)
        rightArm.isFlippedOnYAxis = true
        rightArm.image?.color = .white
        model.parts.append(rightArm)
        
        let tie = PartModel(partToCopy: .neckwear7)
        tie.size.width = 65
        tie.size.height = 65
        tie.offset.width = 94
        tie.offset.height = 24
        tie.image?.color = .black
        model.parts.append(tie)
        
        return model
    }()
}

#Preview {
    NavigationStack {
        Snowperson(snowperson: .chase)
    }
}
