//
//  NavigationPath.swift
//  SwiftBrick
//
//  Created by 狄烨 on 2023/6/6.
//

import SwiftUI
@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
@available(macOS, deprecated: 13)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension SwiftBrickWrapper where Wrapped == Any {
    public struct NavigationPath: Equatable {
        var elements: [AnyHashable]
        
        /// The number of screens in the path.
        public var count: Int { elements.count }
        
        /// WHether the path is empty.
        public var isEmpty: Bool { elements.isEmpty }
        
        public init(_ elements: [AnyHashable] = []) {
            self.elements = elements
        }
        
        public init<S: Sequence>(_ elements: S) where S.Element: Hashable {
            self.init(elements.map { $0 as AnyHashable })
        }
        
        public mutating func append<V: Hashable>(_ value: V) {
            elements.append(value)
        }
        
        public mutating func removeLast(_ k: Int = 1) {
            elements.removeLast(k)
        }
    }
}
@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
@available(macOS, deprecated: 13)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension SwiftBrickWrapper.NavigationPath {
    /// Pushes a new screen via a push navigation.
    /// - Parameter screen: The screen to push.
    mutating func push(_ screen: AnyHashable) {
        elements.push(screen)
    }
    
    /// Pops a given number of screens off the stack.
    /// - Parameter count: The number of screens to go back. Defaults to 1.
    mutating func pop(_ count: Int = 1) {
        elements.pop(count)
    }
    
    /// Pops to a given index in the array of screens. The resulting screen count
    /// will be index.
    /// - Parameter index: The index that should become top of the stack.
    mutating func popTo(index: Int) {
        elements.popTo(index: index)
    }
    
    /// Pops to the root screen (index 0). The resulting screen count
    /// will be 1.
    mutating func popToRoot() {
        elements.popToRoot()
    }
    
    /// Pops to the topmost (most recently pushed) screen in the stack
    /// that satisfies the given condition. If no screens satisfy the condition,
    /// the screens array will be unchanged.
    /// - Parameter condition: The predicate indicating which screen to pop to.
    /// - Returns: A `Bool` indicating whether a screen was found.
    @discardableResult
    mutating func popTo(where condition: (AnyHashable) -> Bool) -> Bool {
        elements.popTo(where: condition)
    }
}
@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
@available(macOS, deprecated: 13)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension SwiftBrickWrapper.NavigationPath {
    /// Pops to the topmost (most recently pushed) screen in the stack
    /// equal to the given screen. If no screens are found,
    /// the screens array will be unchanged.
    /// - Parameter screen: The predicate indicating which screen to go back to.
    /// - Returns: A `Bool` indicating whether a matching screen was found.
    @discardableResult
    mutating func popTo(_ screen: AnyHashable) -> Bool {
        return elements.popTo(screen)
    }
    
    /// Pops to the topmost (most recently pushed) screen in the stack
    /// equal to the given screen. If no screens are found,
    /// the screens array will be unchanged.
    /// - Parameter screen: The predicate indicating which screen to go back to.
    /// - Returns: A `Bool` indicating whether a matching screen was found.
    @discardableResult
    mutating func popTo<T: Hashable>(_: T.Type) -> Bool {
        return popTo(where: { $0 is T })
    }
}
@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
@available(macOS, deprecated: 13)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension SwiftBrickWrapper.NavigationPath {
    /// A codable representation of a navigation path.
    struct CodableRepresentation {
        static let encoder = JSONEncoder()
        static let decoder = JSONDecoder()
        
        var elements: [Codable]
    }
    
    var codable: CodableRepresentation? {
        let codableElements = elements.compactMap { $0 as? Codable }
        guard codableElements.count == elements.count else {
            return nil
        }
        return CodableRepresentation(elements: codableElements)
    }
    
    init(_ codable: CodableRepresentation) {
        // NOTE: Casting to Any first prevents the compiler from flagging the cast to AnyHashable as one that
        // always fails (which it isn't, thanks to the compiler magic around AnyHashable).
        self.init(codable.elements.map { ($0 as Any) as! AnyHashable })
    }
}

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
@available(macOS, deprecated: 13)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension SwiftBrickWrapper.NavigationPath.CodableRepresentation: Encodable {
    fileprivate func generalEncodingError(_ description: String) -> EncodingError {
        let context = EncodingError.Context(codingPath: [], debugDescription: description)
        return EncodingError.invalidValue(elements, context)
    }
    
    fileprivate static func encodeExistential(_ element: Encodable) throws -> Data {
        func encodeOpened<A: Encodable>(_ element: A) throws -> Data {
            try SwiftBrickWrapper<Any>.NavigationPath.CodableRepresentation.encoder.encode(element)
        }
        return try _openExistential(element, do: encodeOpened(_:))
    }
    
    /// Encodes the representation into the encoder's unkeyed container.
    /// - Parameter encoder: The encoder to use.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for element in elements.reversed() {
            guard let typeName = _mangledTypeName(type(of: element)) else {
                throw generalEncodingError(
                    "Unable to create '_mangledTypeName' from \(String(describing: type(of: element)))"
                )
            }
            try container.encode(typeName)
#if swift(<5.7)
            let data = try Self.encodeExistential(element)
            let string = String(decoding: data, as: UTF8.self)
            try container.encode(string)
#else
            let string = try String(decoding: Self.encoder.encode(element), as: UTF8.self)
            try container.encode(string)
#endif
        }
    }
}

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
@available(macOS, deprecated: 13)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension SwiftBrickWrapper.NavigationPath.CodableRepresentation: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        elements = []
        while !container.isAtEnd {
            let typeName = try container.decode(String.self)
            guard let type = _typeByName(typeName) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Cannot instantiate type from name '\(typeName)'."
                )
            }
            guard let codableType = type as? Codable.Type else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "\(typeName) does not conform to Codable."
                )
            }
            let encodedValue = try container.decode(String.self)
            let data = Data(encodedValue.utf8)
#if swift(<5.7)
            func decodeExistential(type: Codable.Type) throws -> Codable {
                func decodeOpened<A: Codable>(type _: A.Type) throws -> A {
                    try NBNavigationPath.CodableRepresentation.decoder.decode(A.self, from: data)
                }
                return try _openExistential(type, do: decodeOpened)
            }
            let value = try decodeExistential(type: codableType)
#else
            let value = try Self.decoder.decode(codableType, from: data)
#endif
            elements.insert(value, at: 0)
        }
    }
}

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
@available(macOS, deprecated: 13)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension SwiftBrickWrapper.NavigationPath.CodableRepresentation: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        do {
            let encodedLhs = try encodeExistential(lhs)
            let encodedRhs = try encodeExistential(rhs)
            return encodedLhs == encodedRhs
        } catch {
            return false
        }
    }
}
