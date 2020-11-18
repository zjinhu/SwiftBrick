# CheckDevice✔️
[![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=How%20to%20detect%20ios%20current%20screen%20size%20or%20device%20type.Just%20use%20this%20repo%20:%20%20%20%20&url=https://github.com/ugurethemaydin/CheckDevice&hashtags=cocoapods,repo,CheckDevice,developers,swift,ios,device,github,deviceDetect)

![CheckDevice](https://github.com/ugurethemaydin/CheckDevice/blob/main/header.jpg)

![language](https://img.shields.io/badge/Language-%20Swift%20-orange.svg)

[![Version](https://img.shields.io/cocoapods/v/CheckDevice.svg?style=flat)](https://cocoapods.org/pods/CheckDevice)
[![License](https://img.shields.io/cocoapods/l/CheckDevice.svg?style=flat)](https://cocoapods.org/pods/CheckDevice)
[![Platform](https://img.shields.io/cocoapods/p/CheckDevice.svg?style=flat)](https://cocoapods.org/pods/CheckDevice)



[![CI Status](https://img.shields.io/travis/ugurethemaydin/CheckDevice.svg?style=flat)](https://travis-ci.org/ugurethemaydin/CheckDevice)

#### **How to detect iOS device models and screen size?**
###### **CheckDevice is detected the current  device model and screen sizes.**

```swift
CheckDevice.size()
```


## Simplify and justify

You can also use

```swift
CheckDevice.isPhone() 
```

to check the device type iPhone.




## CocoaPods or Swift Package Manager (SPM) 

**CheckDevice** is support cocoaPods and SPM.
##
###  CocoaPods
 [CocoaPods](http://cocoapods.org/) is a dependency manager for Xcode projects. To use CheckDevice with CocoaPods simply add the following lines to your PodFile:

```swift
pod 'CheckDevice'
```

And then run:  `$ pod install`

##
### Swift Package Manager
#### The [Swift Package Manager](https://swift.org/package-manager/) automates the distribution of Swift code. To use CheckDevice with SPM, add a dependency to your `Package.swift` file: 



```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/ugurethemaydin/CheckDevice.git", ...)
    ]
)
```


#
### Carthage

###### [Carthage](https://github.com/Carthage/Carthage) is unsupported. 



#
### Usage

Detect a current device and write log:

```swift
CheckDevice.current()
```

## iOS
### Device version
```swift
func myFunc() {
        /*** Display the device version ***/
        switch CheckDevice.version() {
            /*** iPhone ***/
            case .iPhone4:              print("It's an iPhone 4")
            case .iPhone4S:             print("It's an iPhone 4S")
            case .iPhone5:              print("It's an iPhone 5")
            case .iPhone5C:             print("It's an iPhone 5C")
            case .iPhone5S:             print("It's an iPhone 5S")
            case .iPhone6:              print("It's an iPhone 6")
            case .iPhone6S:             print("It's an iPhone 6S")
            case .iPhone6Plus:          print("It's an iPhone 6 Plus")
            case .iPhone6SPlus:         print("It's an iPhone 6 S Plus")
            case .iPhoneSE:             print("It's an iPhone SE")
            case .iPhone7:              print("It's an iPhone 7")
            case .iPhone7Plus:          print("It's an iPhone 7 Plus")
            case .iPhone8:              print("It's an iPhone 8")
            case .iPhone8Plus:          print("It's an iPhone 8 Plus")
            case .iPhoneX:              print("It's an iPhone X")
            case .iPhoneXS:             print("It's an iPhone Xs")
            case .iPhoneXS_Max:         print("It's an iPhone Xs Max")
            case .iPhoneXR:             print("It's an iPhone Xr")
            case .iPhone11:             print("It's an iPhone 11")            
            case .iPhone11Pro:          print("It's an iPhone 11")                        
            case .iPhone11Pro_Max:      print("It's an iPhone 11 Pro Max")                        
            case .iPhone11Pro_Max:      print("It's an iPhone 11 Pro Max")                                    
            case .iPhoneSE2:            print("It's an iPhone SE 2 Gen")                                                
            case .iPhone12Mini:         print("It's an iPhone 12 Mini")                                                            
            case .iPhone12:             print("It's an iPhone 12")                                                                        
            case .iPhone12Pro:          print("It's an iPhone 12 Pro")                                                                                    
            case .iPhone12ProMax:       print("It's an iPhone 12 Pro Max")                                                                                                
        

            /*** iPad ***/
            case .iPad1:           print("It's an iPad 1")
            case .iPad2:           print("It's an iPad 2")
            case .iPad3:           print("It's an iPad 3")
            case .iPad4:           print("It's an iPad 4")
            case .iPad5:           print("It's an iPad 5")
            case .iPad6:           print("It's an iPad 6")
            case .iPad7:           print("It's an iPad 7")            
            
            /*** iPadAir ***/
            case .iPadAir:         print("It's an iPad Air")
            case .iPadAir2:        print("It's an iPad Air 2")
            
            
            /*** iPadMini ***/
            case .iPadMini:        print("It's an iPad Mini")
            case .iPadMini2:       print("It's an iPad Mini 2")
            case .iPadMini3:       print("It's an iPad Mini 3")
            case .iPadMini4:       print("It's an iPad Mini 4")
            
            
            /*** iPadPro ***/
            case .iPadPro9_7Inch:  print("It's an iPad Pro 9.7 Inch")
            case .iPadPro10_5Inch: print("It's an iPad Pro 10.5 Inch")
            case .iPadPro12_9Inch: print("It's an iPad Pro 12.9 Inch")

            /*** iPod ***/
            case .iPodTouch1Gen: print("It's a iPod touch generation 1")
            case .iPodTouch2Gen: print("It's a iPod touch generation 2")
            case .iPodTouch3Gen: print("It's a iPod touch generation 3")
            case .iPodTouch4Gen: print("It's a iPod touch generation 4")
            case .iPodTouch5Gen: print("It's a iPod touch generation 5")
            case .iPodTouch6Gen: print("It's a iPod touch generation 6")
            case .iPodTouch7Gen: print("It's a iPod touch generation 7")            
            
            
            /*** Watch ***/
            case .WatchOriginal38mm: print("It's a Apple Watch Original 38MM")            
            case .WatchOriginal42mm: print("It's a Apple Watch Original 42MM")                        
            
            /*** All watch alternative included... Some examples ***/
            case .Watch1Gen38mm: print("It's a Apple Watch 1 38MM")                                    
            case .Watch2Gen42mm: print("It's a Apple Watch 2 42MM")                                                
            case .Watch4Gen40mm: print("It's a Apple Watch 4 38MM")                                                            
            case .Watch6Gen40mm: print("It's a Apple Watch 6 40MM")        
            case .WatchSE44mm: print("It's a Apple Watch SE 44MM")                                                                                    
           
           
           
            /*** Simulator ***/
            case .Simulator:    print("It's a Simulator")

            /*** Unknown ***/
            default:            print("It's an unknown device")
        }
    }
```

## Device screen size
```swift
func myFunc() {
        /*** Display the device screen size ***/
        switch CheckDevice.size() {
            case .screen3_5Inch:  print("It's a 3.5 inch screen")
            case .screen4Inch:    print("It's a 4 inch screen")
            case .screen4_7Inch:  print("It's a 4.7 inch screen")
            case .screen5_4Inch:  print("It's a 5.4 inch screen")            
            case .screen5_5Inch:  print("It's a 5.5 inch screen")
            case .screen5_8Inch:  print("It's a 5.8 inch screen")
            case .screen6_1Inch:  print("It's a 6.1 inch screen")
            case .screen6_5Inch:  print("It's a 6.5 inch screen")
            case .screen6_7Inch:  print("It's a 6.7 inch screen")            
            case .screen7_9Inch:  print("It's a 7.9 inch screen")
            case .screen9_7Inch:  print("It's a 9.7 inch screen")
            case .screen10_5Inch: print("It's a 10.5 inch screen")
            case .screen12_9Inch: print("It's a 12.9 inch screen")
            default:              print("Unknown size")
        }
}
```

## Device type
```swift
func myFunc() {
        /*** Display the device type ***/
        switch CheckDevice.type() {
            case .iPod:         print("It's an iPod")
            case .iPhone:       print("It's an iPhone")
            case .iPad:         print("It's an iPad")
            case .Watch:         print("It's an Apple Watch")            
            case .Simulator:    print("It's a Simulated device")
            default:            print("Unknown device type")
        }
}

```

or 

```swift
func myFunc() {
        /*** Display the device type ***/
        if (CheckDevice.isPad()){
            print("It's an iPad")
        }
        else if (CheckDevice.isPhone()){
            print("It's an iPhone")
        }
        else if (CheckDevice.isPod()){
            print("It's an iPod")
        }
        else if (CheckDevice.isWatch()){
            print("It's an Apple Watch")
        }
        else if (CheckDevice.isSimulator()){
            print("It's a Simulated device")
        }
}

```

## Mac
### Mac version
```swift
func myFunc() {
        /*** Display the mac version ***/
        switch CheckDevice.type() {
            case .iMac:         print("It's an iMac")
            case .macBook:      print("It's a MacBook")
            case .macBookAir:   print("It's a MacBook Air")
            case .macBookPro:   print("It's a MacBook Pro")
            default:            print("Unknown device type")
        }
    }
```

## Mac screen size
```swift
func myFunc() {
        /*** Display the mac screen size ***/
        switch CheckDevice.size() {
            case .screen11Inch:     print("It's a 11 inch screen")
            case .screen12Inch:     print("It's a 12 inch screen")
            case .screen13Inch:     print("It's a 13 inch screen")
            case .screen15Inch:     print("It's a 15 inch screen")
            case .screen17Inch:     print("It's a 17 inch screen")
            case .screen21_5Inch:   print("It's a 21.5 inch screen")
            case .screen27Inch:     print("It's a 27 inch screen")
            default:                print("Unknown size")
        }
}
```

## Helpers
```swift
func myFunc() {
        /*** Helpers ***/
        if CheckDevice.size() == Size.screen4Inch {
            print("It's a 4 inch screen")
        }

        if CheckDevice.size() > Size.screen4_7Inch {
            print("Your device screen is larger than 4.7 inch")
        }

        if CheckDevice.size() < Size.screen4_7Inch {
            print("Your device screen is smaller than 4.7 inch")
        }

        if CheckDevice.size() == Size.screen27Inch {
            print("It's a 27 inch screen")
        }
        
        if CheckDevice.size() > Size.screen15Inch {
            print("Your mac screen is larger than 15 inch")
        }
        
        if CheckDevice.size() < Size.screen15Inch {
            print("Your mac screen is smaller than 15 inch")
        }

        if CheckDevice.isRetina() {
            print("It's a retina display")
        }
        
}
```

#
## Author

Uğur Ethem AYDIN, ugur@metromedya.com 
[@ugurethemaydin](http://twitter.com/ugurethemaydin)

## License

CheckDevice is available under the [MIT](https://choosealicense.com/licenses/mit/) license. See the LICENSE file for more info.
