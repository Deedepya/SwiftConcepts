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
    
    func savebjectsInDB(_ objects: List<ProfileRealmModel>) {
        guard let realmDb = realmDb else {
            return
        }
        
        objects.forEach { profile in
            print(profile)
            try! realmDb.write {
                realmDb.add(profile)
            }
        }
        
//        ForEach(objects) { profile in
//            print(profile)
//            try! realmDb.write {
//                realmDb.add(profile)
//            }
//        }
    }
    
    func deleteObjectFromDb(_ object: ProfileRealmModel) {
        guard let realmDb = realmDb else {
            return
        }
        
        try! realmDb.write {
            realmDb.delete(object)
        }
    }
    
    func updateInfo(_ field: String, currentValue: String, updatedValue: String) throws {
        guard let realmDb = realmDb else {
            return
        }
        
        let list = try getMatchedObjects(field, value: currentValue) //here if error is thrown then error will be returned. Already 'getMatchedObjects' function is throwing, so need to again throw in current function
        print(list)
        try! realmDb.write {
            list.setValue(updatedValue, forKey: "\(field)")
        }
    }
    
    func updateInfoHardcoded(for object: ProfileRealmModel) {
        guard let realmDb = realmDb else {
            return
        }
        
        try! realmDb.write {
            object.name = "hardCodedName"
        }
    }
    
    // MARK: - Read operations
    func getMatchedObjects<T>(_ field: String, value: T) throws -> Results<ProfileRealmModel> {
        if (realmDb != nil) {
            if let value = value as? Int {
                let predicate = NSPredicate(format: "%K = %d", field, value)
                return realmDb!.objects(ProfileRealmModel.self).filter(predicate)
            } else if let value = value as? String {
                let predicate = NSPredicate(format: "%K = %@", field, value)
                return realmDb!.objects(ProfileRealmModel.self).filter(predicate)
            }
            return realmDb!.objects(ProfileRealmModel.self)
//            let predicate = NSPredicate(format: "%K = %@", field, value)
//            let list = realmDb!.objects(ProfileRealmModel.self)
//            //let matches = list.where { $0.name == value as! String }
//            let matches = list.where { $0.rating == value as! Int }
//            print(matches)
//            return matches
            //return realmDb!.objects(ProfileRealmModel.self).filter(predicate)
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
