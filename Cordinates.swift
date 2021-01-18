//
//  Cordinates.swift
//  Stormy
//

import Foundation

struct Coordinate
{
    let latitude: Double
    let longitude: Double
}

//..Method: a type of custom representation
extension Coordinate: CustomStringConvertible
{
    var description: String
    {
        return "\(latitude),\(longitude)"
    }
    
    static var alcatrazIsland: Coordinate
    {
        return Coordinate (latitude: 37.8267,longitude: -122.4233)
    }
}
