//
//  SwiftUIView.swift
//  SwiftBrick
//
//  Created by 狄烨 on 2023/5/13.
//  Copyright © 2023 狄烨 . All rights reserved.
//

import SwiftUI
import SwiftBrick
@available(iOS 14.0, *)
struct SwiftUIView: View {
    //    @Environment(\.dismiss) private var dismiss
    private var bgColors: [Color] = [ .red, .yellow, .green, .orange, .pink ]
    
    @State private var path: [Color] = []

    @StateObject var co = AppColorScheme()
    
    var body: some View {
        SS.NavigationStack(path: $path) {
            List(bgColors, id: \.self) { bgColor in
                SS.NavigationLink(value: bgColor) {
                    Text(bgColor.description)
                }
                
            }
            .ss.navigationDestination(for: Color.self) { color in
                VStack {
                    Text("\(path.count), \(path.description)")
                        .font(.headline)
                    
                    HStack {
                        ForEach(path, id: \.self) { color in
                            color
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                    }
                    List(bgColors, id: \.self) { bgColor in
                        
                        SS.NavigationLink(value: bgColor) {
                            Text(bgColor.description)
                        }
                        
                    }
                    .listStyle(.plain)

                }
                .listStyle(.plain)
                .navigationTitle("Color")
            }
            .toolbar {
                SS.ToolbarItem(placement: .bottomBar) {
                    Button {
                        co.darkModeSetting = .dark
                    } label: {
                        Image(systemName: "circle")
                    }
                }
            }
            
        }
        
    }
}

@available(iOS 14.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
