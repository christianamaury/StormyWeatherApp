//
//  DarkAPIClient.swift
//  Stormy
//

import Foundation

class DarkSkyAPIClient
{
    fileprivate let darkSkyApiKey = "a43da7b64e8d9a6e918a4ef22e56f6a8"
    
    lazy var baseUrl: URL = {
       return URL(string: "https://api.darksky.net/forecast/\(self.darkSkyApiKey)/")!
    }()
    
    let downloader = JSONDownloader()
    
    //This type is part of this Codeable functionality
    //and will handle most of the decoding work
    let decoder = JSONDecoder()
    
    let session: URLSession
    
    
    //We need a configuration object in order to create a session
    init(configuration: URLSessionConfiguration)
    {
        self.session = URLSession(configuration: configuration)
    }
    
    //Convenience init
    convenience init()
    {
        self.init(configuration: .default)
    }
    
    typealias WeatherCompletionHandler = (Weather?, Error?) -> Void
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, Error?) -> Void
    
    private func getWeather(at coordinate: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler)
    {
        
        guard let url = URL(string: coordinate.description, relativeTo: baseUrl) else
        {
            completion(nil, DarkSkyError.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        //Session is an instance from URL Session
        let task = session.dataTask(with: request) {data, response, error in
            
            DispatchQueue.main.async
                {
                    if let data = data
                    {
                        guard let httpResponse = response as? HTTPURLResponse else {
                            completion(nil, DarkSkyError.requestedFailed)
                            //Guard needs to exit the current scope
                            return
                        }
                        if httpResponse.statusCode == 200
                        {
                            //We're going to parse from our data
                            //to our stype using that new decoder.
                            //Its a throwing operation so we need to
                            //encapsulate this..
                            do
                            {
                                let weather = try self.decoder.decode(Weather.self, from: data)
                                completion(weather, nil )
                            }
                            catch let error
                            {
                                //..If it doesn't work
                                completion(nil, error)
                            }
                        }
                        else
                        {
                            completion(nil, DarkSkyError.invalidData)
                        }
                        
                    }
                    else if let error = error
                    {
                        completion(nil, error)
                    }
            }
        }
        
        task.resume()
    }
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler)
{
//Calling
    getWeather(at: coordinate){weather, error in
        
        completion(weather?.currently, error)
        
        }
    }
}
