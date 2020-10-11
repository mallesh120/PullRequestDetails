import Foundation

class GetPrs {
    func getPrs() {
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://api.github.com/repos/mallesh120/PullRequestDetails/pulls")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("token e2be83a181d811a143ea9dcf85db460a91b5943a", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                if let jsonArray = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Dictionary<String,Any>]
                {
                    for i in jsonArray {
                        let x = i["head"] as! [String: Any]
                        let y = x["user"] as! [String: Any]

                        print(i["title"]!)
                        print(x["sha"]!)
                        print(y["login"]!)
                    }
                }
                semaphore.signal()
            }
        }
        task.resume()
        semaphore.wait()
    }
}

