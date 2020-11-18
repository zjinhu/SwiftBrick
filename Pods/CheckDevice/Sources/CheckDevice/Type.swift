//
//  Type.swift
//  CheckDevice
//  
//  Created by Uğur Ethem AYDIN @ugurethemaydin on 8.11.2020.
//  Copyright © 2020
//


public enum Type: String {
    #if os(iOS)
    case iPhone
    case iPad
    case iPod
    case simulator
    #elseif os(OSX)
    case iMac
    case macMini
    case macPro
    case macBook
    case macBookAir
    case macBookPro
    case xserve
    #endif
    case Watch
    case unknown
}
