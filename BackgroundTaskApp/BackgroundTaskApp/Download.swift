//
//  Download.swift
//  BackgroundTaskApp
//
//  Created by dedeepya reddy salla on 22/07/23.
//

import Foundation

struct Download {
    var dowloadState: DownloadState = .none
    var resumeData: Data?
    var progress: Double = 0.0
    var urlSessionTask: URLSessionTask?
    var isDownloading = false
}

struct JSONHelper {

    static func readJSON() -> [Track]? {
        do {
            if let fileURL = Bundle.main.url(forResource: "music-datasource", withExtension: "json") {
                let data = try Data(contentsOf: fileURL)
                let response = try JSONDecoder().decode([Track].self, from: data)
                return response
            }
        } catch let error  {
            print(error.localizedDescription)
            return nil
        }
        return nil
    }
}
