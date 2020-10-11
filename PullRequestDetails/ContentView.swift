//
//  ContentView.swift
//  PullRequestDetails
//
//  Created by Tanikella, Sai Mallesh Kum  (S.) on 10/11/20.
//

import SwiftUI

struct ContentView: View {
    let variable = GetPrs()

    init() {
        variable.getPrs()
    }

    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
