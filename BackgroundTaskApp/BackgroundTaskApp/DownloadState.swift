//
//  DownloadState.swift
//  BackgroundTaskApp
//
//  Created by dedeepya reddy salla on 22/07/23.
//

import Foundation

enum DownloadState: Int, CustomStringConvertible {
    
    case none = 0
    case start
    case pause
    case resume
    case cancel
    case alreadyDownloaded
    
    var description: String {
        switch self {
        case .start:
            return "Download about start"
        case .resume:
            return "Download will resume"
        case .pause:
            return "Download is paused"

        default:
            return "default"
        }
    }
}
