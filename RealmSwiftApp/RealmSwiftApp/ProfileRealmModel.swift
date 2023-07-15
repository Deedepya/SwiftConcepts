//
//  ProfileRealmModel.swift
//  RealmSwiftApp
//
//  Created by dedeepya reddy salla on 15/07/23.
//

import Foundation
import RealmSwift

class ProfileRealmModel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var rating: Int = 0
}
