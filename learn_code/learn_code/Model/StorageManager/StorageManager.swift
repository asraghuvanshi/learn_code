//
//  StorageManager.swift
//  learn_code
//
//  Created by Amit Raghuvanshi on 26/12/2023.
//

import Foundation
import FirebaseStorage


class StorageManger {
    typealias uploadPicture = (Result <String , Error>)
    
    static let shared = StorageManger()
    private let storage = Storage.storage().reference()
    
    
    public func uploadProfile(with data: Data, filename:String, completion: @escaping (uploadPicture) -> Void) {
        storage.child("images/\(filename)").putData(data , metadata: nil, completion: { metadata , error in
            
            guard  error == nil else {
                completion(.failure(FailedToUploadError.failedToUpload))
                return
            }
        })
        
        storage.child("images/\(filename)").downloadURL(completion: { url, error in
            guard let url = url else {
                completion(.failure(FailedToUploadError.faildedToDownload))
                return
            }
            
            let urlString = url.absoluteString
            completion(.success(urlString))
        })
        
    }
    
    
    public enum FailedToUploadError: Error {
        case failedToUpload
        case faildedToDownload
    }
}
