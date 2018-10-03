//
//  DocumentDetailViewController.m
//  ios-documents-objc
//
//  Created by Conner on 10/3/18.
//  Copyright © 2018 Conner. All rights reserved.
//

#import "DocumentDetailViewController.h"
#import "NSString+WordCount.h"

@interface DocumentDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *wordCountLabel;
@property (strong, nonatomic) IBOutlet UITextField *documentTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *documentTextView;

- (IBAction)saveDocument:(id)sender;

@end

@implementation DocumentDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self documentTextView] setDelegate:self];
}

- (void)textViewDidChange:(UITextView *)textView {
    NSString *wordCount = [NSString stringWithFormat:@"%i", [[textView text] wordCount]];
    [[self wordCountLabel] setText:wordCount];
}

- (void)saveDocument:(id)sender {
    NSString *title = [[self documentTitleTextField] text];
    NSString *text = [[self documentTextView] text];
    [[self documentController] createDocumentWithTitle:title text:text];
    [[self navigationController] popViewControllerAnimated:true];
}

- (void)updateViews {
    if ([self document]) {
        NSString *title = [[self document] title];
        self.title = title;
        NSString *documentText = [[self document] text];
        NSString *wordCount = [NSString stringWithFormat:@"%i", [[self document] documentWordCount]];
        [[self documentTitleTextField] setText:title];
        [[self documentTextView] setText:documentText];
        [[self wordCountLabel] setText:wordCount];
    }
}

@end
