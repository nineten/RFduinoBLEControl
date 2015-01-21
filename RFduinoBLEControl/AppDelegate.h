//
//  AppDelegate.h
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 20/1/15.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CBCentralManagerDelegate, CBPeripheralDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) CBCentralManager* cbmanager;
@property (strong, nonatomic) CBPeripheral* cbperipheral;
@property (strong, nonatomic) NSMutableArray *nDevices;
@property MainViewController* mainViewController;

- (void)setupCoreBluetooth;
- (void)startBLEScanning;
- (void)stopBLEScanning;

@end

