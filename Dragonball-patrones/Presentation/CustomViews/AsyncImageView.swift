//
//  AsyncImageView.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 4/10/24.
//

import UIKit

final class AsyncImageView: UIImageView {
    private var workItem: DispatchWorkItem?
    
    func setDetailImage(_ string: String) {
        let url = URL(string: string)!
        downloadWithURLSession(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    private func downloadWithURLSession(
        url: URL,
        completion: @escaping (UIImage?) -> Void
    ) {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
            guard let data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        .resume()
    }
    
    func setImage(_ string: String) {
        if let url = URL(string: string) {
            setImage(url)
        }
    }
    
    func setImage(_ url: URL) {
        let workItem = DispatchWorkItem {
            let image = (try? Data(contentsOf: url)).flatMap { UIImage(data: $0) }

            DispatchQueue.main.async { [weak self] in
                self?.image = image
                self?.workItem = nil
            }
        }
        DispatchQueue.global().async(execute: workItem)
        self.workItem = workItem
    }
    
    func cancel() {
        workItem?.cancel()
        workItem = nil
    }
}
