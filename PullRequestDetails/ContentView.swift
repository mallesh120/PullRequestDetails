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

    // Call the method once the app is initialized
    init() {
        prList = getPrDetails.getPrs()
    }

    var body: some View {
        // Table View with the required details
        List(prList) { pr in
            VStack(alignment: .leading) {
                Text(verbatim: "User: " + pr.userLogin)
                    .font(.title)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                Text(verbatim: "Commit: " +  pr.merge_commit_sha)
                    .font(.body)
                    .fontWeight(.regular)
                Text(verbatim: "Commit Message: " + pr.title)
                    .font(.body)
                    .fontWeight(.regular)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
