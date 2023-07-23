//
//  DownloadQueueView.swift
//  BackgroundTaskApp
//
//  Created by dedeepya reddy salla on 22/07/23.
//

import SwiftUI

struct DownloadQueueView: View {
    @ObservedObject var downloadManager = DownloadManager.shared
   // @ObservedObject var backgroundMessages = DownloadBackgroundMessages.shared

    var body: some View {
        List {
            ForEach(downloadManager.tracks, id: \.id) { track in
                VStack(alignment: .leading, spacing: 8) {
                    Text(track.track.trackCensoredName)
                    Button(
                        action: {
                            let url = URL(string: track.track.previewURL)!
                            downloadManager.startDownload(track: track)
                        },
                        label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                    )
                    ProgressView(track.task!.progress)
                }
            }
        }
        .navigationBarTitle("Downloads")
        .navigationBarItems(trailing: self.startDownloadButton)
    }

    @ViewBuilder var startDownloadButton: some View {
        Button(
            action: startDownload,
            label: {
                Image(systemName: "square.and.arrow.down")
            }
        )
    }

    //---added new comment for testing reset
    func startDownload() {
        downloadManager.downloadAll()
    }

}

struct DownloadQueueView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadQueueView()
    }
}
