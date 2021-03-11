//
//  AudioItemQueue.swift
//  AudioPlayer
//
//  Created by Mac on 27/06/2021.
//


import Foundation

extension URL {
    //swiftlint:disable variable_name
    /// A boolean value indicating whether a resource should be considered available when internet connection is down
    /// or not.
    var ap_isOfflineURL: Bool {
        return isFileURL || scheme == "ipod-library" || host == "localhost" || host == "127.0.0.1"
    }
}
