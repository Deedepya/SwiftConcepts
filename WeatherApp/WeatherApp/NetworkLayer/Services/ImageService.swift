//
//  ImageService.swift
//  WeatherApp
//
//  Created by dedeepya reddy salla on 05/06/23.
//

import UIKit



class ImageService {
    
    var imageRequest: WeatherIconDataRequest
    var networkService: RestNetworkService
    private var imageCache: NSCache<AnyObject, AnyObject>?
    
    private let lock = NSLock()
    
    init(req: WeatherIconDataRequest, networkService: RestNetworkService = DefaultRestNetworkService(), imageCach: NSCache<AnyObject, AnyObject>) {
        imageRequest = req
        self.networkService = networkService
        imageCache = imageCach
    }
    
    func insertInCache(_ image: UIImage?, for url: String) {
        guard let image = image else { return }
        lock.lock()
        defer {
            lock.unlock()
        }
        imageCache?.setObject(image, forKey: url as AnyObject)
    }
    
    func downloadImage(completion: @escaping (UIImage?, Error?) -> Void) {
        
        networkService.request(imageRequest) { result in
            switch result {
            case .success(let response):
                guard let image: UIImage = response as? UIImage else {
                    return
                }
                completion(image, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getWeatherIcon(completion: @escaping (UIImage?) -> Void) {
        
        if let cacheImage = imageCache?.object(forKey: imageRequest.url as AnyObject) as? UIImage {
            completion(cacheImage)
        } else {
            downloadImage { [self] image, error in
                guard let image = image else {
                    return
                }
                self.insertInCache(image, for: imageRequest.url)
                completion(image)
            }
        }
    }
}
