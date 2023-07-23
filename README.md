# SwiftConcepts changes 2

# RealmSwiftApp

1.To use RealmSwift, first get its pod

Pdfile for xcode 14.3

```
# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'RealmSwiftApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RealmSwiftApp

pod 'Reachability', '~> 3.2'
pod 'RealmSwift', '~> 10.41'

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
               end
          end
   end
end

```
Steps to create table in RealmDatabse
1.Create instance for RealmDatabse. Use only one instance throughout the app then keep adding new tables (new class objects).
2.To create each table in realm database, first declare its structure in app. Each table must inherit 'Object' and as 'Object' is of type
class, only classes can inherit them.

2a. create realmModel using class eg:

```
class ProfileRealmModel {
    @objc dynamic var name: String = ""
    @objc dynamic var age: String = ""
    @objc dynamic var rating: String = ""
}
```


error: if initializer is not present, then it throws errors. Swift NSObject requires initializer unless they are optionals.

```
class ProfileRealmModel: Object {
    @objc dynamic var name: String
    @objc dynamic var age: String
    @objc dynamic var rating: String
}

```
3.Realm db Details 
a.var realm: Realm? --> database instance is of type Realm

b.realm db returns the matched results as list of struct objects eg: Results<ProfileRealmModel>
More details can be found here: Put realm link

4.Realm db operations:

  a.you need realdb instance to get access to its databse
  b.if you want to add new object, update or delete then first get access to write transaction through 
  realm.write
  c.To add new object use  realmDb.add(object), to delete object use realmDb.delete(object)
  to update use list.setValue(updatedValue, forKey: "\(field)")
  Note: for all these operations first write transaction must be started
  d.For reading values, you don't write transaction. To get matched results use 
```
func getMatchedObjects(_ field: String, value: String) throws -> Results<ProfileRealmModel> {
        if (realmDb != nil) {
            let predicate = NSPredicate(format: "%K = %@", field, value)
            return realmDb!.objects(ProfileRealmModel.self).filter(predicate)
        } else {
            throw RealmError.noMatchError
        }
    }
```

5.Useful tips:
1.Create instance for RealmDatabse. Use only one instance throughout the app then keep adding new tables (new class objects).
2.To create each table in realm database, first declare its structure in app. Each table must inherit 'Object' and as 'Object' is of type class, only classes can inherit them
eg:

```
import RealmSwift

class ProfileRealmModel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var rating: Int = 0
}
```
