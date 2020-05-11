//
//  e_FileManager.swift
//  ExecutorApp
//
//  Created by Дарья Селезнёва on 11.05.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import Foundation

extension FileManager {
    func clearTmpDirectory() {
        let tmpDirURL = FileManager.default.temporaryDirectory
        if let tmpDirectory = try? contentsOfDirectory(atPath: tmpDirURL.path) {
            try? tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try removeItem(atPath: fileUrl.path)
            }
        }
    }
    
    func sizeOfTmpFolder() -> String? {
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
            var folderSize: Int64 = 0
            for content in contents {
                do {
                    let fullContentPath = NSTemporaryDirectory() + "/" + content
                    let fileAttributes = try FileManager.default.attributesOfItem(atPath: fullContentPath)
                    folderSize += fileAttributes[FileAttributeKey.size] as? Int64 ?? 0
                } catch _ {
                    continue
                }
            }

            /// This line will give you formatted size from bytes ....
            let fileSizeStr = ByteCountFormatter.string(fromByteCount: folderSize, countStyle: ByteCountFormatter.CountStyle.file)
            return fileSizeStr

        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
