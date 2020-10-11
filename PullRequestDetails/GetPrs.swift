import Foundation

struct prDetails: Identifiable {
    var id = UUID()

    let userLogin: String
    let merge_commit_sha: String
    let title: String
}

class GetPrs {
    func getPrs() -> [prDetails] {
        var listArray = [prDetails]()
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://api.github.com/repos/mallesh120/PullRequestDetails/pulls")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("token ba19a55d7c7f262e6c9092c11c31d413b8488a86", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                if let prListJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Dictionary<String,Any>]
                {
                    for pr in prListJSON {
                        let commitDetails = pr["head"] as! [String: Any]
                        let userDetails = commitDetails["user"] as! [String: Any]
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

