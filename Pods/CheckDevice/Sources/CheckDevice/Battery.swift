//
//  Battery.swift
//  CheckDevice
//
//  Created by Uğur Ethem AYDIN on 18.11.2020.
//

import UIKit

public struct Battery {
        /// Return battery state
        public var state: UIDevice.BatteryState {
            enableBatteryMonitoringIfNecessary()
            return UIDevice.current.batteryState
        }
        
        /// Battery level from 0.0 to 1.0. Will enable monitoring if not enabled.
        public var level: Float {
            enableBatteryMonitoringIfNecessary()
            return UIDevice.current.batteryLevel
        }
        
        private func enableBatteryMonitoringIfNecessary() {
            guard !UIDevice.current.isBatteryMonitoringEnabled else { return }
            UIDevice.current.isBatteryMonitoringEnabled = true
        }
    }
