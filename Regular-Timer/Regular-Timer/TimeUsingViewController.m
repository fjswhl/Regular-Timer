//
//  TimeUsingViewController.m
//  Regular-Timer
//
//  Created by Shuyu on 13-11-13.
//  Copyright (c) 2013年 Shuyu. All rights reserved.
//

#import "TimeUsingViewController.h"
#import "TimeUsingCell.h"
#import "SHUAppDelegate.h"
#import "Project.h"

@interface TimeUsingViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (IBAction)addProject:(id)sender;

@end

@implementation TimeUsingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"载入项目出错" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@",error);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addProject:(id)sender
{
    NSManagedObjectContext *managedObjectContext = [_fetchedResultsController managedObjectContext];
    
    NSEntityDescription *entity = [[_fetchedResultsController fetchRequest] entity];
    [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:managedObjectContext];
    
    NSError *error;
    if (![managedObjectContext save:&error]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"添加项目出错" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@",error);
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[_fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TimeUsingCell";
    
    TimeUsingCell *cell = (TimeUsingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [leftUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                    icon:[UIImage imageNamed:@"check.png"]];
        [leftUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                    icon:[UIImage imageNamed:@"clock.png"]];
        [leftUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
         
                                                    icon:[UIImage imageNamed:@"cross.png"]];
        [leftUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                    icon:[UIImage imageNamed:@"list.png"]];
        
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                    title:@"More"];
        [rightUtilityButtons sw_addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                    title:@"Delete"];
        
        cell = [[TimeUsingCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier
                                  containingTableView:tableView // Used for row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
        
        cell.projectName = [[UILabel alloc] initWithFrame:CGRectMake(19, 12, 150, 30)];
        cell.continuedTime = [[UILabel alloc] initWithFrame:CGRectMake(19, 50, 190, 21)];
        cell.projectIcon = [[UIImageView alloc] initWithFrame:CGRectMake(240, 3, 74, 68)];
        
        cell.projectName.font = [UIFont systemFontOfSize:26.0];
        cell.continuedTime.font = [UIFont systemFontOfSize:10.0];
        
        [cell.contentView addSubview:cell.projectName];
        [cell.contentView addSubview:cell.continuedTime];
        [cell.contentView addSubview:cell.projectIcon];
        
        /*      数据初始化       */
        
        Project *aProjcet = [_fetchedResultsController objectAtIndexPath:indexPath];
        
//        NSDate *date = [aProjcet valueForKey:@"startDate"];
        NSInteger hours = [[aProjcet valueForKey:@"continuedHour"] integerValue];
        
        cell.projectName.text = [aProjcet valueForKey:@"projectName"];
        cell.continuedTime.text = [NSString stringWithFormat:@"自从%d起已经坚持了%d小时",2013,hours];
        cell.projectIcon.image = nil;
        
    }
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - SWTableViewDelegate

- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    NSManagedObjectContext *managedObjectContext = [_fetchedResultsController managedObjectContext];
    
    switch (index) {
            
        case 0:
        {
            NSLog(@"More button was pressed");
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"More more more" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            [managedObjectContext deleteObject:[_fetchedResultsController objectAtIndexPath:cellIndexPath]];
            
            NSError *error;
            if (![managedObjectContext save:&error]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"删除项目出错" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert show];
                NSLog(@"%@",error);
            }
            
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            [self.tableView reloadData];

            break;
        }
        default:
            break;
    }
}


#pragma mark - FetchedResultsController Property

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    SHUAppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appdelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Project" inManagedObjectContext:managedObjectContext];
    
    /*      暂时仅以projcectID排序       */
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"projectID" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    return _fetchedResultsController;
}

#pragma mark - FetchedResultsController Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
        case NSFetchedResultsChangeMove:
            break;
    }
}

@end
