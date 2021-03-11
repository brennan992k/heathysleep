//
//  AudioItemQueue.swift
//  AudioPlayer
//
//  Created by Mac on 27/06/2021.
//


import CoreMedia

extension CMTime {
    /// Initializes a `CMTime` instance from a time interval.
    ///
    /// - Parameter timeInterval: The time in seconds.
    init(timeInterval: TimeInterval) {
        self.init(seconds: timeInterval, preferredTimescale: 1000000000)
    }

    //swiftlint:disable variable_name
    /// Returns the TimerInterval value of CMTime (only if it's a valid value).
    var ap_timeIntervalValue: TimeInterval? {
        if flags.contains(.valid) {
            let seconds = CMTimeGetSeconds(self)
            if !seconds.isNaN {
                return TimeInterval(seconds)
            }
        }
        return nil
    }
}
