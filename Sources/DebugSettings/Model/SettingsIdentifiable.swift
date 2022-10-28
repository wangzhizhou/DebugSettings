//
//  File.swift
//  
//
//  Created by joker on 2022/10/27.
//

import Foundation

public protocol SettingsIdentifiable<ID> {

    associatedtype ID : Hashable

    var id: Self.ID { get }
}


public extension SettingsIdentifiable {
    
    var id: UUID { UUID() }
    
}
