//
//  ImageService.swift
//  ScrollStackViews
//
//  Created by Felipe Montoya on 2/22/22.
//

import Foundation

protocol ImageServiceDelegate {
    func didFinishedWith(_ result: Result<Data,Error>)
    func serviceNeedsURL() -> URL
}

struct ImageService {
    
    var delegate: ImageServiceDelegate
    
    func downloadImage()  {
        let url = self.delegate.serviceNeedsURL()
        URLSession.shared
            .dataTask(
                with: URLRequest(url: url)) { data, response, error in
                guard error == nil else {
                    return self.delegate.didFinishedWith(.failure(error!))
                }
                    self.delegate.didFinishedWith(.success(data ?? Data()))
               // completion()
            }
            .resume()
        
    }
}
