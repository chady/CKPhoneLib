//
//  CKMasterViewController.m
//  CKPhoneLibTest
//
//  Created by Chady Kassouf on 2/20/13.
//  Copyright (c) 2013 Chady Kassouf. All rights reserved.
//

#import "CKMasterViewController.h"
#import <AddressBook/AddressBook.h>
#import "CKDetailViewController.h"

@interface CKMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation CKMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _objects = [[NSMutableArray alloc] init];
    
    [self loadContacts:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *object = _objects[indexPath.row];
    cell.textLabel.text = [object objectForKey:@"name"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}



-(IBAction)loadContacts:(id)sender {
    NSLog(@"Syncing");
    CFErrorRef err;
    
    
    
    
    ABAddressBookRef m_addressbook = ABAddressBookCreateWithOptions(NULL, &err);
    
    ABAddressBookRequestAccessWithCompletion(m_addressbook, ^(bool granted, CFErrorRef error) {
        if (granted) {
            [self performSelectorInBackground:@selector(readContacts) withObject:nil];
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"I need permission to access your contacts before I can continue" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    });
    
}

-(void)readContacts {
    [_objects removeAllObjects];
    
    CFErrorRef err;
    
    ABAddressBookRef m_addressbook = ABAddressBookCreateWithOptions(NULL, &err);
    if (!m_addressbook)
    {
        NSLog(@"opening address book");
    }
    
	CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(m_addressbook);
	CFIndex nPeople = ABAddressBookGetPersonCount(m_addressbook);
    NSLog(@"Scanning %li contacts", nPeople);
    
    for (int i = 0; i < nPeople; i++) {
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,i);
        
        
        NSString * firstName = (__bridge NSString *) ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        NSString * lastName  = (__bridge NSString *) ABRecordCopyValue(ref, kABPersonLastNameProperty);
        
        NSString * name = firstName;
        if (lastName != nil && [lastName length] > 0) {
            if (name == nil) {
                name = lastName;
            } else {
                name = [name stringByAppendingFormat:@" %@", lastName];
            }
        }
        
        if (name == nil) {
            name = @"n/a";
        }
        
        
        ABMultiValueRef phones = ABRecordCopyValue(ref, kABPersonPhoneProperty);
		int count =  ABMultiValueGetCount(phones);
        if (count > 0) {
            
            NSMutableArray * numbers = [NSMutableArray arrayWithCapacity:count];
            
            
            for(CFIndex j = 0; j < count; j++)
            {
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(phones, j);
                
                [numbers addObject:(__bridge NSString *)phoneNumberRef];
                
                
            }
            
            NSDictionary * contact = @{@"name" : name, @"numbers": numbers};
            [_objects addObject:contact];
        } else {
            NSLog(@"Contact has no phones, skipping");
        }
        
    }

    [_objects sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 objectForKey:@"name"] compare:[obj2 objectForKey:@"name"] options:NSCaseInsensitiveSearch];
    }];

    [self.tableView reloadData];

    
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath

}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
