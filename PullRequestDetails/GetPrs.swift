import Foundation

// Struct defined as Identifiable - can be used in Any Class
struct prDetails: Identifiable {
    var id = UUID()

    let userLogin: String
    let merge_commit_sha: String
    let title: String
}

// Class to hit GitHub API
class GetPrs {

    // This Method hits the GitHub API and returns the list of PRs in PullRequestDetails Repo
    func getPrs() -> [prDetails] {
        var listArray = [prDetails]()
        let semaphore = DispatchSemaphore (value: 0)

        // request url for GitHub API
        var request = URLRequest(url: URL(string: "https://api.github.com/repos/mallesh120/PullRequestDetails/pulls?Authorization=token%20ba19a55d7c7f262e6c9092c11c31d413b8488a86")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        // Get Request using URLSession - returns List of PRs as JSON
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                // Parse the output JSON data
                if let prListJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Dictionary<String,Any>]
                {
                    // Loop through the list of PRs
                    for pr in prListJSON {
                        // Get the Commit Details
                        let commitDetails = pr["head"] as! [String: Any]

                        // Get User Details
                        let userDetails = commitDetails["user"] as! [String: Any]

                        // Store the details and append them to the Array
                        listArray.append(prDetails(userLogin: userDetails["login"] as! String, merge_commit_sha: commitDetails["sha"] as! String, title: pr["title"] as! String))
                    }
                }
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
        return listArray
    }
}

