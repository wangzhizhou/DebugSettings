//
//  File.swift
//  
//
//  Created by joker on 2022/10/29.
//

import Foundation

public struct SettingsIdentifier {
    
    private let segs: [String]
    
    public init(segs: [String] = [String]()) {
        self.segs = segs
    }
    
    public func append(_ seg: String) -> SettingsIdentifier {
        var newSegs = Array(self.segs)
        newSegs.append(seg)
        return SettingsIdentifier(segs: newSegs)
    }
    
    var persistenceKey: String {
        get {
            let ret = self.segs.reduce("") { partialResult, seg in
                guard !partialResult.isEmpty else {
                    return seg
                }
                if !seg.isEmpty {
                    return partialResult.appending(".").appending(seg)
                }
                return partialResult
            }
            return ret
        }
    }
}

extension SettingsIdentifier: Equatable {
    static public func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.segs == rhs.segs
    }
}
