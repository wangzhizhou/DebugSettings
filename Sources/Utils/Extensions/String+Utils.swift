//
//  String+Utils.swift
//  DebugSettings
//
//  Created by joker on 2023/3/31.
//

import Foundation

public extension String {
    
    func toJSONObject() -> Any? {
        guard let jsonData = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    }
    
    func toJsonDictionary() -> [String: Any]? {
        return self.toJSONObject() as? Dictionary<String,Any>
    }
    
    func toJsonArray() -> Array<Any>?{
        return self.toJSONObject() as? Array<Any>
    }
}
