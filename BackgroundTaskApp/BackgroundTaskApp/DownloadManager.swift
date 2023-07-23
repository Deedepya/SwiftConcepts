//
//  DownloadManager.swift
//  BackgroundTaskApp
//
//  Created by dedeepya reddy salla on 22/07/23.
//

import os
import Combine
import Foundation


/*
 points to remember
 1.As its a download manager, we might download more than one task at at time
 */
class DownloadManager: NSObject, ObservableObject {
    static var shared = DownloadManager()
    private var urlSession: URLSession!
    @Published var tasks: [URLSessionTask] = []
    @Published var tracks:[newTrack] = []
    
    private override init() {
        super.init()
        let config = URLSessionConfiguration.background(withIdentifier: "\(Bundle.main.bundleIdentifier!).background")
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        setupDataSource()
    }
    
    
    private func setupDataSource() {
        guard let response = JSONHelper.readJSON() else { return }
        
        let subTracks = response
        subTracks.forEach{ track in
            let url = URL(string: track.previewURL)!
            let task = self.urlSession.downloadTask(with:url)
            var newtrack = newTrack(task: task, track: track)
            tracks.append(newtrack)
        }
    }
    
    func startDownload(track: newTrack) {
        track.task?.resume()
        //tasks.append(task)
    }
    
    func downloadAll() {
        tracks.forEach{ track in
            track.task?.resume()
        }
    }
    
//    private func updateTasks() {
//        urlSession.getAllTasks { tasks in
//            DispatchQueue.main.async {
//                self.tasks = tasks
//            }
//        }
//    }
    
//    func resumeTask(with track: Track, downloadState: DownloadState) {
//        guard let download = self.activeDownloads[URL(string: track.previewURL)!] else { return }
//
//
//        if let resumeData = download.resumeData {
//            download.sessionTask = urlSession.downloadTask(withResumeData: resumeData)
//        } else {
//            download.sessionTask = urlSession.downloadTask(with: URL(string: track.previewURL)!)
//        }
//
//        download.dowloadState = downloadState
//        download.sessionTask?.resume()
//        download.isDownloading = true
//
//
//    }
//
//
//    func start(downloadState: DownloadState) {
//        let task = urlSession.downloadTask(with: url)
//        task.resume()
//        let session = urlSession.downloadTask(with: URL(string: "")!)
//        session.resume()
//        var download = Download()
//        download.dowloadState = .start
//        download.isDownloading = true
//    }
}


extension DownloadManager: URLSessionDelegate, URLSessionDownloadDelegate {
    
    //download delegate mandatory function
    func urlSession(_: URLSession, downloadTask: URLSessionDownloadTask, didWriteData _: Int64, totalBytesWritten _: Int64, totalBytesExpectedToWrite _: Int64) {
        os_log("Progress %f for %@", type: .debug, downloadTask.progress.fractionCompleted, downloadTask)
    }

    //download delegate mandatory function
    func urlSession(_: URLSession, downloadTask _: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        os_log("Download finished: %@", type: .info, location.absoluteString)
        // The file at location is temporary and will be gone afterwards
    }

    func urlSession(_: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            os_log("Download error: %@", type: .error, String(describing: error))
        } else {
            os_log("Task finished: %@", type: .info, task)
        }
    }
}
