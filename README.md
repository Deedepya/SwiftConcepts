# SwiftConcepts

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
class, only classes can inherit them
2a.
