//
//  TaskEx.swift
//  SwiftBrick
//
//  Created by iOS on 2023/5/23.
//

import SwiftUI

@available(iOS 13.0, *)
struct TaskModifier: ViewModifier {
    let priority: TaskPriority
    let action: @Sendable () async -> Void
    @State var task: Task<Void, Never>? = nil

    func body(content: Content) -> some View {
        content
            .onAppear {
                if task != nil {
                    task?.cancel()
                }
                task = Task(priority: priority, operation: action)
            }
            .onDisappear {
                task?.cancel()
            }
    }
}

@available(iOS 13.0, *)
extension View {
    @_disfavoredOverload
    public func task(priority: TaskPriority = .userInitiated, _ action: @escaping @Sendable () async -> Void) -> some View {
        self.modifier(TaskModifier(priority: priority, action: action))
    }
}
