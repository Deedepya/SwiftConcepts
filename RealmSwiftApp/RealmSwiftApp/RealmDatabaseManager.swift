//
//  RealmDatabaseManager.swift
//  RealmSwiftApp
//
//  Created by dedeepya reddy salla on 15/07/23.
//

import Foundation
import RealmSwift

enum RealmError: Error {
    case noMatchError
}

class RealmDatabaseManager {
    var realmDb: Realm?
    
    public func creatNewProfile(_ name: String, age: Int, rating: Int ) -> ProfileRealmModel
    {
        //creates new ComicBook
        let profile = ProfileRealmModel()
        profile.name = name
        profile.age = age
        profile.rating = rating
        return profile
    }
    
    // MARK: - Write operations
    func saveNewObjectInDB(_ object: ProfileRealmModel) {
        guard let realmDb = realmDb else {
            return
        }
        
        try! realmDb.write {
            realmDb.add(object)
        }
    }
    
    func deleteObjectFromDb(_ object: ProfileRealmModel) {
        guard let realmDb = realmDb else {
            return
        }
        
        try! realmDb.write {
            realmDb.delete(object)
        }
    }
    
    func updateInfo(_ field: String, updatedValue: String) throws {
        guard let realmDb = realmDb else {
            return
        }
        
        let list = try getMatchedObjects(field, value: updatedValue) //here if error is thrown then error will be returned. Already 'getMatchedObjects' function is throwing, so need to again throw in current function
        try! realmDb.write {
            list.setValue(updatedValue, forKey: "\(field)")
        }
    }
    
    func updateInfoHardcoded(for object: ProfileRealmModel) {
        guard let realmDb = realmDb else {
            return
        }
        
        try! realmDb.write {
            object.name = "hardcoded direct"
        }
    }
    
    // MARK: - Read operations
    func getMatchedObjects(_ field: String, value: String) throws -> Results<ProfileRealmModel> {
        if (realmDb != nil) {
            let predicate = NSPredicate(format: "%K = %@", field, value)
            return realmDb!.objects(ProfileRealmModel.self).filter(predicate)
        } else {
            throw RealmError.noMatchError
        }
    }
    
    public func getMatchedObjects(_ title: String) throws -> Results<ProfileRealmModel>
    {
        if (realmDb != nil) {
                    let predicate = NSPredicate(format: "name = %@", title)
                    return realmDb!.objects(ProfileRealmModel.self).filter(predicate)
                } else {
                    throw RealmError.noMatchError
                }
    }
}
