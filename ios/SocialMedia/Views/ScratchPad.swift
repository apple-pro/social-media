//
//  ScratchPad.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/16/20.
//

import SwiftUI

struct ScratchPad: View {
    var body: some View {
        VStack {
            Text("Test1")
            Text("Test2")
        }.background(Color.gray.opacity(0.1))
    }
}

struct ScratchPad_Previews: PreviewProvider {
    static var previews: some View {
        ScratchPad()
    }
}
