//
//  ShareViewController.swift
//  ShareReel
//
//  Created by kumara.c on 17/07/25.
//

import UIKit
import Social
import SwiftUI

class ShareViewController: UIViewController, SharePostViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = extensionContext?.inputItems.first as? NSExtensionItem,
           let attachments = item.attachments {
            for provider in attachments {
                if provider.hasItemConformingToTypeIdentifier("public.url") {
                    provider.loadItem(forTypeIdentifier: "public.url", options: nil) { (item, error) in
                        if let url = item as? URL {
                            // Handle the shared URL here
                            print("Received URL: \(url)")
                            if let sharedDefaults = UserDefaults(suiteName: "group.com.genai.reelDeel") {
                                sharedDefaults.set(url.absoluteString, forKey: "sharedURL")
                                sharedDefaults.synchronize()
                            }
                            // Optionally pass it to your main app via App Group, UserDefaults, etc.
                            DispatchQueue.main.async {
                                let contentView = UIHostingController(rootView: SharePostView(url: url, delegate: self))
                                self.addChild(contentView)
                                self.view.addSubview(contentView.view)
                                // set up constraints
                                contentView.view.translatesAutoresizingMaskIntoConstraints = false
                                contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                                contentView.view.bottomAnchor.constraint (equalTo: self.view.bottomAnchor).isActive = true
                                contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                                contentView.view.rightAnchor.constraint (equalTo: self.view.rightAnchor).isActive = true
                            }
                        } else {
                            self.close()
                        }
                    }
                }
            }
        } else {
            self.close()
        }
    }
    
    func close() {
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    func sharePostViewClose() {
        self.close()
    }
    
    func sharePostToTheApp() {
        let configName = "com.genai.ReelDeel.BackgroundSessionConfig"
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: configName)
        // Extensions aren't allowed their own cache disk space. Need to share with application
        sessionConfig.sharedContainerIdentifier = "group.com.genai.reelDeel"
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        guard let request = prepareUrlRequest(urlString: "https://1de437f1e4f6.ngrok-free.app/analyze") else {
            print("Problem occured while creating URLRequest")
            return
        }
        
        let task = session.dataTask(with: request)
        task.resume()
//        Commenting this code because we dont want to open the app when user saves a url
//        if let url = URL(string: "ReelDeelSchema://") {
//            openURL(url)
//        } else {
//            print("the url is invalid")
//        }
    }
    
    func prepareUrlRequest(urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            print ("invalid url")
            return nil
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let jsonObject = NSMutableDictionary()
        jsonObject["username"] = "instorefashions"
        
        // Create the JSON payload
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            request.httpBody = jsonData
        } catch let error {
            print("JSON Error: \(error.localizedDescription)")
            return nil
        }
        return request
    }
    
    /// Open URL Code
    @objc @discardableResult func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                if #available(iOS 18.0, *) {
                    application.open(url, options: [:], completionHandler: nil)
                    return true
                } else {
                    return application.perform(#selector(openURL(_:)), with: url) != nil
                }
            }
            responder = responder?.next
        }
        return false
    }
    

}

extension ShareViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any] {
                print("Recieved data \(data)")
                print("Recieved json \(json)")
            } else if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                print("Recieved json \(jsonArray)")
            }
        } catch let error{
            print("Recieved data \(data)")
            print("JsonSerialization \(error)")
        }
    }
    //This function is to detect any errors
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error = error {
            print("there was an error \(error)")
        }
    }
}
