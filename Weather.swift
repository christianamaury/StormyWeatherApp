//
//  Weather.swift
//  Stormy
//

import Foundation

struct Weather: Codable
{
    let currently: CurrentWeather
}

extension Weather
{
    init?(json: [String: AnyObject])
    {
        guard let currentWeatherJson = json["currently"] as? [String: AnyObject], let currentWeather =
            CurrentWeather(json: currentWeatherJson) else
        {
            return nil
        }
        
        self.currently = currentWeather
    }
}

