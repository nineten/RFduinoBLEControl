//
//  AppDelegate.m
//  RFduinoBLEControl
//
//  Created by Jayden.Ma on 20/1/15.
//
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.example.RFduinoBLEControl" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"RFduinoBLEControl" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"RFduinoBLEControl.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - CBCentralManager delegate function

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSLog(@"central: state changed");
    
    if (central.state != CBCentralManagerStatePoweredOn) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"BLE not supported !" message:[NSString stringWithFormat:@"CoreBluetooth return state: %d",central.state] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"central: discovered peripheral >> %@",peripheral.name);
    
    peripheral.delegate = self;
    [central connectPeripheral:peripheral options:nil];
        
    // store the peripherals to prevent ARC i think?
    [self.nDevices addObject:peripheral];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"central: connected to peripheral >> %@", peripheral.name);
    if (self.isScanning) {
        [peripheral discoverServices:nil];
    } else {
        if (peripheral == self.cbperipheral) {
            [peripheral discoverServices:nil];
            if ([peripheral.name isEqualToString:@"JBLELed"]) {
                [self.mainViewController successfulPairing:JBLELEDModule];
            } else if ([peripheral.name isEqualToString:@"JBLEServo"]) {
                [self.mainViewController successfulPairing:JBLEServoModule];
            } else if ([peripheral.name isEqualToString:@"JBLEDCMotor"]) {
                [self.mainViewController successfulPairing:JBLEDCMotorModule];
            }
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"central: disconnected from peripheral >> %@", peripheral.name);
    if (peripheral == self.cbperipheral) {
        self.cbperipheral.delegate = nil;
        self.cbperipheral = nil;
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"central: failed to connect to peripheral >> %@", peripheral.name);
}

#pragma mark - CBperipheral delegate function

- (void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSLog(@"peripheral: discovered service >> %@", peripheral.name);
    
    if (self.isScanning) {
        [self.cbmanager cancelPeripheralConnection:peripheral];
        if ([peripheral.name hasPrefix:@"JBLE"]) {
            [self.jBLEDevices addObject:peripheral];
            [self.mainViewController refreshTable];
        }
    } else {
        if (peripheral == self.cbperipheral) {
            for (CBService *service in peripheral.services) {
                NSLog(@"peripheral: service found >> %@",service);
                [peripheral discoverCharacteristics:nil forService:service];
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"peripheral: discovered characteristics for service");
    
    if (peripheral == self.cbperipheral) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            NSLog(@"%@", characteristic);
            if ([self.cbperipheral.name isEqualToString:@"JBLELed"]) {
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2222"]]) {
                    self.ledModuleCharacteristic = characteristic;
                }
            } else if ([self.cbperipheral.name isEqualToString:@"JBLEServo"]) {
                
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2222"]]) {
                    self.servoModuleCharacteristic = characteristic;
                }
            } else if ([self.cbperipheral.name isEqualToString:@"JBLEDCMotor"]) {
                
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2222"]]) {
                    self.servoModuleCharacteristic = characteristic;
                }
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"peripheral: wrote value for characteristics");
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"peripheral: updated value for characteristics");
}

#pragma mark - BLE related functions

- (void)setupCoreBluetooth {
    NSLog(@"setting up core bluetooth manager.");
    self.cbmanager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.cbmanager.delegate = self;
    self.isScanning = false;
}

- (void)startBLEScanning {
    self.nDevices = [[NSMutableArray alloc] init];
    self.jBLEDevices = [[NSMutableArray alloc] init];
    [self.mainViewController refreshTable];
    
    if (self.cbmanager.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"central: starting scan.");
        self.isScanning = true;
        [self.cbmanager scanForPeripheralsWithServices:nil options:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Bluetooth not turned on." message:[NSString stringWithFormat:@"CoreBluetooth return state: %d",self.cbmanager.state] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)stopBLEScanning {
    NSLog(@"central: stopping scan.");
    [self.cbmanager stopScan];
    self.isScanning = false;
}

- (void)connectToBLEDevice:(CBPeripheral *)peripheral {
    self.cbperipheral = peripheral;
    self.cbperipheral.delegate = self;
    [self.cbmanager connectPeripheral:peripheral options:nil];
}

- (void)disconnectFromBLEDevice:(CBPeripheral *)peripheral {
    [self.cbmanager cancelPeripheralConnection:peripheral];
}


@end
