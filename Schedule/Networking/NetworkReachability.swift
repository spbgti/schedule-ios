//
//  NetworkReachability.swift
//  schedule
//
//  Created by Vladislav Glumov on 25.03.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Alamofire

protocol NetworkReachabilityDelegate: class {
    func networkReachability(_ status: NetworkReachabilityManager.NetworkReachabilityStatus)
}

final class NetworkReachability {
    
    private let networkReachabilityDispatch: DispatchQueue
    
    private let networkReachabilityManager: NetworkReachabilityManager?
    
    weak var delegate: NetworkReachabilityDelegate?
    
    init(with identifier: String, host: String = "www.Apple.com") {
        networkReachabilityManager = NetworkReachabilityManager(host: host)
        networkReachabilityDispatch = DispatchQueue(label: "com.qmobi.aurora.\(identifier)Queue")
    }
    
    func listenNetworkReachability() {
        networkReachabilityManager?.startListening(onQueue: networkReachabilityDispatch) { [weak self] status in
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.networkReachability(status)
            }
        }
    }
    
    func stopListenNetworkReachability() {
        networkReachabilityManager?.stopListening()
    }
    
}
