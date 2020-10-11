//
//  ContentView.swift
//  PullRequestDetails
//
//  Created by Tanikella, Sai Mallesh Kum  (S.) on 10/11/20.
//

import SwiftUI

struct ContentView: View {
    let getPrDetails = GetPrs()
    var prList = [prDetails]()


    init() {
        prList = getPrDetails.getPrs()
    }

    var body: some View {
        List(0..<5) { item in
            Text(verbatim: "Hello, World!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
