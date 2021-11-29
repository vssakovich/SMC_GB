//
//  VKLoginViewController.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 27.11.21.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8011606"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        guard urlComponents.url != nil else {
            print("URL not valid")
            return
        }
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
}

extension VKLoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params["access_token"]
        
        print(token)
        
        guard token != nil else {
            print("Invalid token")
            return
        }
        Session.instance.token = token!
        
        decisionHandler(.cancel)
        
    }
    
    func getUserFriends() {
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "friends.get"
        urlConstructor.queryItems = [ URLQueryItem(name: "access_token", value: Session.instance.token), URLQueryItem(name: "v", value: "5.81")]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        task.resume()
    }
    
    func getUserPhotos() {
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "photos.getAll"
        urlConstructor.queryItems = [ URLQueryItem(name: "access_token", value: Session.instance.token), URLQueryItem(name: "v", value: "5.81")]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        task.resume()
    }
    
    func getUserGroups() {
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "groups.get"
        urlConstructor.queryItems = [ URLQueryItem(name: "access_token", value: Session.instance.token), URLQueryItem(name: "v", value: "5.81")]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        task.resume()
    }
    
    func searchGroups() {
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "groups.search"
        urlConstructor.queryItems = [ URLQueryItem(name: "access_token", value: Session.instance.token), URLQueryItem(name: "v", value: "5.81")]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
        task.resume()
    }
    
    
}
