//
//  JSONDownloader.swift
//  Stormy
//
import Foundation

//This class will initiate a network session..
class JSONDownloader
{
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
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, DarkSkyError?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask
    {
        let task = session.dataTask(with: request) {data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestedFailed)
                //Guard needs to exit the current scope
                return
            }
            
            if httpResponse.statusCode == 200
            {
                if let data = data
                {
                    do
                    {
                     let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                     completion(json, nil)
                    }
                    catch {
                        completion(nil, .jsonParsingFailure)
                    }
                }
                else
                {
                    completion(nil, .invalidData)
                }
            }
            else
            {
                completion(nil, .responseUnsuccessful(statusCode: httpResponse.statusCode))
            }
        }
   
      return task
    }
}
