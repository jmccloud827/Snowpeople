import SwiftData
import SwiftUI

@Model final class SnowpersonModel {
    var name = "Snowperson"
    var createdDate = Date.now
    var background = Background.originalDay
    private var persistedParts: [PartModel] = []
    
    @Transient var parts: [PartModel] {
        get {
            persistedParts
        }
        set {
            for (index, part) in newValue.enumerated() {
                part.zIndex = index
            }
            persistedParts = newValue
        }
    }
    
    init() {}
    
    func duplicatePart(_ part: PartModel) -> PartModel {
        let copy = PartModel(partToCopy: part)
        copy.offset = .zero
        parts.append(copy)
        
        return copy
    }
    
    func getPartById(_ id: ObjectIdentifier) -> PartModel? {
        return parts.first(where: { $0.id == id })
    }
    
    func getCanMovePartBackwardByID(_ id: ObjectIdentifier) -> Bool {
        let sortedParts = persistedParts.sorted { $0.zIndex < $1.zIndex }
        guard let index = sortedParts.firstIndex(where: { $0.id == id }) else {
            return false
        }
        
        return index > 0
    }
    
    func getCanMovePartForwardByID(_ id: ObjectIdentifier) -> Bool {
        let sortedParts = persistedParts.sorted { $0.zIndex < $1.zIndex }
        guard let index = sortedParts.firstIndex(where: { $0.id == id }) else {
            return false
        }
        
        return index < parts.count - 1
    }
    
    func movePartBackwardByID(_ id: ObjectIdentifier) {
        let sortedParts = persistedParts.sorted { $0.zIndex < $1.zIndex }
        let index = sortedParts.firstIndex { $0.id == id }
        if let index, index > 0 {
            let partToMove = sortedParts[index]
            let partToMoveBeforeIt = sortedParts[index - 1]
            parts.swapAt(partToMove.zIndex, partToMoveBeforeIt.zIndex)
        }
    }
    
    func movePartForwardByID(_ id: ObjectIdentifier) {
        let sortedParts = persistedParts.sorted { $0.zIndex < $1.zIndex }
        let index = sortedParts.firstIndex { $0.id == id }
        if let index, index < parts.count - 1 {
            let partToMove = sortedParts[index]
            let partToMoveBeforeIt = sortedParts[index + 1]
            parts.swapAt(partToMove.zIndex, partToMoveBeforeIt.zIndex)
        }
    }
    
    enum Background: String, Codable, CaseIterable {
        case originalDay = "Original (Day)"
        case originalNight = "Original (Night)"
    }
}
