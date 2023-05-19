//
//  SwiftUIView.swift
//  SwiftBrick
//
//  Created by 狄烨 on 2023/5/13.
//  Copyright © 2023 狄烨 . All rights reserved.
//

import SwiftUI
@available(iOS 13.0, *)
struct SwiftUIView: View {
    var body: some View {
        VStack{
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Spacer()
        }.background(Color.orange)
    }
}
@available(iOS 13.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
