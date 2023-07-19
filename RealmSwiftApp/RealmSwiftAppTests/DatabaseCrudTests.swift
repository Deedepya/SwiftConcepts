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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("setUp called")
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        let realm = try! Realm()
        databaseManager.realmDb = realm
    }
    
    func createTwoNewObjects() -> List<ProfileRealmModel> {
        let dedeepyaProfile = databaseManager.creatNewProfile("Dedeepya", age: 30, rating: 10)
        let puppyProfile = databaseManager.creatNewProfile("Puppy", age: 25, rating: 10)
//        let profiles = [dedeepyaProfile, puppyProfile]
        //        profiles.append(dedeepyaProfile)
        //        profiles.append(puppyProfile)
        let profiles = List<ProfileRealmModel>()
      //  profiles.append(objectsIn: [dedeepyaProfile, puppyProfile])
        profiles.append(dedeepyaProfile)
        profiles.append(puppyProfile)
        return profiles
    }
   
    func testSavingObjects() {
        do {
            //testing saving one object at a time
            let list = createTwoNewObjects()
            print(list)
            databaseManager.saveNewObjectInDB(list[0])
            databaseManager.saveNewObjectInDB(list[1])
            let foundProfiles = try databaseManager.getMatchedObjects("Dedeepya")
            XCTAssertEqual(foundProfiles.count, 1)
            XCTAssertEqual(foundProfiles.first?.age, 30)
            
            //testing saving multiple objects at a time
            let list1 = createTwoNewObjects()
            databaseManager.savebjectsInDB(list1)
            //let multipleProfiles = try databaseManager.getMatchedObjects("name", value: "Dedeepya")
            let multipleProfiles = try databaseManager.getMatchedObjects("rating", value: 10)
            XCTAssertEqual(multipleProfiles.count, 2)
            XCTAssertEqual(multipleProfiles[1].name, "Puppy")
        } catch {
            XCTAssert(false, "Saving to database is not successfull \(error)")
        }
    }

    func testFetchResults() {
        //testing saving multiple objects at a time
        let list = createTwoNewObjects()
        databaseManager.savebjectsInDB(list)
        //let multipleProfiles = try databaseManager.getMatchedObjects("name", value: "Dedeepya")
        do {
        let multipleProfiles1 = try databaseManager.getMatchedObjects("name", value: "Puppy")
        XCTAssertEqual(multipleProfiles1[0].name, "Puppy")
            XCTAssertEqual(multipleProfiles1.count,1)
        let multipleProfiles2 = try databaseManager.getMatchedObjects("rating", value: 10)
        XCTAssertEqual(multipleProfiles2.count,2)
        } catch {
            XCTAssert(false, "getMatchedObjects function is not working \(error)")
        }
    }
    
    func testUpdatingObject() {
        let list = createTwoNewObjects()
        databaseManager.savebjectsInDB(list)
        databaseManager.updateInfoHardcoded(for: list[1])
        XCTAssertTrue(list[1].name == "hardCodedName")

        do {
            let puppyList = try databaseManager.getMatchedObjects("Puppy")
            XCTAssertTrue(puppyList.count == 0)
        } catch {
            XCTAssert(false, "updateInfoHardcoded function is not working \(error)")
        }
        
        do {
            try databaseManager.updateInfo("name", currentValue: "hardCodedName", updatedValue: "Puppy")
            let updatedList = try databaseManager.getMatchedObjects("Puppy")
            XCTAssertEqual(updatedList.count, 1)
        } catch {
            XCTAssert(false, "updateInfo function is not working \(error)")
        }
    }

    func testDeletingObject() {
        let list = createTwoNewObjects()
        XCTAssertEqual(list[0].age, 30)
        XCTAssertEqual(list.count, 2)
        databaseManager.savebjectsInDB(list)
        XCTAssertEqual(list.count, 2)
        databaseManager.deleteObjectFromDb(list[1])
        do {
            let list0 = try databaseManager.getMatchedObjects("Puppy")
            XCTAssertEqual(list0.count, 0)

            let list1 = try databaseManager.getMatchedObjects("Dedeepya")
            XCTAssertEqual(list1.count, 1)
        } catch {
            XCTAssert(false, "Deleting object in database is not successful \(error)")
        }
        
    }

}
