//
//  VideoEncoder.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 09.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import AVFoundation

class VideoService {
    static func encodeVideo(videoUrl: URL, outputUrl: URL? = nil, completion: @escaping (URL?) -> Void ) {
        
        var finalOutputUrl: URL? = outputUrl
        
        if finalOutputUrl == nil {
            var url = videoUrl
            url.deletePathExtension()
            url.appendPathExtension("mp4")
            finalOutputUrl = url
        }
        
        if FileManager.default.fileExists(atPath: finalOutputUrl!.path) {
            print("Converted file already exists \(finalOutputUrl!.path)")
            completion(finalOutputUrl)
            return
        }
        
        let asset = AVURLAsset(url: videoUrl)
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality) else { completion(nil); return }
        exportSession.outputURL = finalOutputUrl!
        exportSession.outputFileType = AVFileType.mp4
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRangeMake(start: start, duration: asset.duration)
        exportSession.timeRange = range
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously() {
            switch exportSession.status {
            case .failed:
                print("Export failed: \(exportSession.error != nil ? exportSession.error!.localizedDescription : "No Error Info")")
            case .cancelled:
                print("Export canceled")
            case .completed:
                completion(finalOutputUrl!)
            default:
                break
            }
        }
    }

    static func generateThumbnail(path: URL) -> String? {
        do {
            let asset = AVURLAsset(url: path, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            print(cgImage)
            let thumbnail = UIImage(cgImage: cgImage)
            if let imageData = thumbnail.pngData() {
                let strBase64 = imageData.base64EncodedString()
                return strBase64
            }
            else {
                return nil
            }
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
}
