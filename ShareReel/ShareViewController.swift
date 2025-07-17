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
        if let url = URL(string: "ReelDeelSchema://") {
            openURL(url)
        } else {
            print("the url is invalid")
        }
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
