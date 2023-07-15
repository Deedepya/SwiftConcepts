//
//  DatabaseCrudTests.swift
//  RealmSwiftAppTests
//
//  Created by dedeepya reddy salla on 15/07/23.
//

import XCTest
@testable import RealmSwiftApp
import RealmSwift

final class DatabaseCrudTests: XCTestCase {

    let databaseManager = RealmDatabaseManager()
    
    override func setUpWithError() throws {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        let realm = try! Realm()
        databaseManager.realmDb = realm
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
   
    func testSavingNewObject() {
        
        do {
            let profile = databaseManager.creatNewProfile("Dedeepya", age: 30, rating: 10)
            let profile1 = databaseManager.creatNewProfile("Puppy", age: 25, rating: 10)
            databaseManager.saveNewObjectInDB(profile)
            databaseManager.saveNewObjectInDB(profile1)
            let foundProfiles = try databaseManager.getMatchedObjects("Dedeepya")
            XCTAssertEqual(foundProfiles.count, 2)
            
            XCTAssertEqual(foundProfiles.first?.age, 30)
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }


    }

//    func testUpdatingObject() {
//        databaseManager.updateInfo("name", updatedValue: "Energetic")
//    }
//
//    func testDeletingObject() {
//        let profile = databaseManager.creatNewProfile("Dedeepya", age: 30, rating: 10)
//        databaseManager.deleteObjectFromDb(profile)
//    }
}
