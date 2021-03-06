//
//  ViewController.m
//  temperature
//
//  Created by user on 9/27/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmtControl;
@property (weak, nonatomic) IBOutlet UISlider *sliderSize;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;
@property (weak, nonatomic) IBOutlet UILabel *lblMin;
@property (weak, nonatomic) IBOutlet UILabel *lblMax;
@property (weak, nonatomic) IBOutlet UILabel *lblFrom;

-(int) getOld;
-(void) setOld:(int) oldvalue;
@end

@implementation ViewController

int Old;

-(int) getOld
{
    return Old;
}

-(void) setOld:(int) oldvalue
{
    Old = oldvalue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CalculateTemperature:2 :0];
    
    [self setOld:0];
    self.lblMin.text =@"0";
    self.lblMax.text = @"100";

}




- (IBAction)sliderChange:(id)sender {
    int segvalue =(int)self.sliderSize.value;
    [self.lblFrom setText:[NSString stringWithFormat:@"%d",segvalue]];
    int seg = (int)self.sgmtControl.selectedSegmentIndex;
    int value = 0;
    switch (seg) {
        case 0:
            value = segvalue * 1.8 + 32;
            break;
        case 1:
            value = segvalue + 273;
            break;
        case 2:
            value = ((segvalue -273) *1.8) +32;
            break;
        case 3:
            value = (segvalue -32) /1.8;
            break;
        
        default:
            break;
    }
    
    [self.lblResult setText:[NSString stringWithFormat:@"%d",value]];}

- (IBAction)sgmtChange:(id)sender {

    [self UpdateValues];
   
    
}
              
              
-(void) CalculateTemperature:(int) fromMetric :(int) toMetric
{
    int to =toMetric;
    int actualValue = self.sliderSize.value;
    int from = fromMetric;
    int newValue = 0;
    switch (to) {
        case 0:
            if(from == 2) //from celcius
            {
                newValue = actualValue * 1.8 + 32;
            }
            else if(from == 1)
            {
                newValue = ((actualValue -273) *1.8) +32;;
            }
            break;
            
        case 1:
            if(from == 2) //from celcius
            {
                newValue = actualValue + 273;
            }
            else if(from == 0)
            {
                newValue = actualValue + 241;
            }
            break;
        
            
        case 2:
            if(from == 0) //from far
            {
                newValue = (actualValue - 32) / 1.8;
            }
            else if(from == 1)
            {
                newValue = actualValue - 273;
            }
            break;
        
        default:
            break;
    }
    
   [self.lblFrom setText:[NSString stringWithFormat:@"%d", actualValue]];
    [self.lblResult setText:[NSString stringWithFormat:@"%d", newValue]];
    //self.sliderSize.value = newValue;
   
}

-(void) UpdateValues
{
    int from;
    int to;
    int old = [self getOld];
    int actualSeg =(int) self.sgmtControl.selectedSegmentIndex;
    int actualValue = (int)self.sliderSize.value;
    int newValue = 0;
    switch (actualSeg) {
        case 0:
            self.sliderSize.minimumValue = 0;
            self.sliderSize.maximumValue = 100;
            self.lblMin.text =@"0";
            self.lblMax.text = @"100";
            [self setOld:0];
            from = 2;
            to = 0;
            if(old == 2)
           {
               
               newValue = actualValue - 273;
           }
            else
                if(old == 3)
                {
                    newValue = (actualValue - 32)/1.8;
                }
                else
           {
               newValue = actualValue;
           }
            break;
            
        case 1:
            from = 2;
            to = 1;
            self.sliderSize.minimumValue = 0;
            self.sliderSize.maximumValue = 100;
            self.lblMin.text =@"0";
            self.lblMax.text = @"100";
            [self setOld:1];
            if(old == 2)
            {
                newValue = actualValue - 273 ;
            }
            else
                if(old == 3)
                {
                    newValue = (actualValue - 32)/1.8;
                }
            else
            {
                newValue = actualValue;
            }
            break;
            
        case 2:
            from = 1;
            to = 0;
            self.sliderSize.minimumValue = 273;
            self.sliderSize.maximumValue = 373;
            self.lblMin.text =@"273";
            self.lblMax.text = @"373";
            [self setOld:2];
            if(old == 0 || old == 1)
            {
            newValue = actualValue + 273 ;
            }
            else
            {
                newValue = (actualValue - 32)/1.8 + 273;
                
            }
            break;
        
        case 3:
            from = 0;
            to = 2;
            self.sliderSize.minimumValue = 32;
            self.sliderSize.maximumValue = 212;
            self.lblMin.text =@"32";
            self.lblMax.text = @"212";
            [self setOld:3];
            if(old == 0|| old == 1)
            {
                newValue = (actualValue *1.8) +32 ;
            }
            else
            {
                newValue = (actualValue -273) *1.8 +32;
            }
            
            break;
        
        default:
            break;
    }
    
    self.sliderSize.value = newValue;
    [self CalculateTemperature:from :to];
    
}





@end
