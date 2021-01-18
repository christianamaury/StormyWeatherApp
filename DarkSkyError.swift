//
//  DarkSkyError.swift
//  Stormy
//

import Foundation

//Error
enum DarkSkyError: Error
{
    case requestedFailed
    case responseUnsuccessful (statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidUrl
}
