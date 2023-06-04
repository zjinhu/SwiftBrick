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
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List{
            Text("12")
        }
        .background(Color.orange)
        .ss.scrollIndicators(.hidden)
        .ss.task {
            
        }
    }
}
@available(iOS 14.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
