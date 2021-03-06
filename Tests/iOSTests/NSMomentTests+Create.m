//
//  NSMomentTests+Create.m
//  NSMomentTests
//
//  Created by YannickL on 26/10/2013.
//
//

#import <XCTest/XCTest.h>

#define EXP_SHORTHAND
#import "Expecta.h"

#import "NSMoment.h"

@interface NSMomentTests_Create : XCTestCase

@end

@implementation NSMomentTests_Create

- (void)setUp
{
    [super setUp];
    
    [[NSMoment proxy] setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
}

- (void)tearDown
{
    [[NSMoment proxy] setLocale:[NSLocale currentLocale]];
    
    [super tearDown];
}

- (void)testCreateFromArray
{
    NSMoment *moment = [NSMoment momentWithArray:@[@2010]];
    expect([moment date]).notTo.beNil();
    
    moment = [NSMoment momentWithArray:@[@2010, @1]];
    expect([moment date]).notTo.beNil();
    
    moment = [NSMoment momentWithArray:@[@2010, @1, @12]];
    expect([moment date]).notTo.beNil();
    
    moment = [NSMoment momentWithArray:@[@2010, @1, @12, @1]];
    expect([moment date]).notTo.beNil();
    
    moment = [NSMoment momentWithArray:@[@2010, @1, @12, @1, @1]];
    expect([moment date]).notTo.beNil();
    
    moment = [NSMoment momentWithArray:@[@2010, @1, @12, @1, @1, @1]];
    expect([moment date]).notTo.beNil();

    NSCalendar *calendar         = [[NSMoment proxy] calendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year              = 2010;
    components.month             = 1;
    components.day               = 12;
    components.hour              = 1;
    components.minute            = 1;
    components.second            = 1;
    
    NSDate *date        = [calendar dateFromComponents:components];
    NSMoment *reference = [NSMoment momentWithDate:date];
    
    expect([moment isEqualToMoment:reference]).to.beTruthy();
}

- (void)testCreateFromDate
{
    NSDate *reference = [NSDate date];
    
    NSMoment *moment = [NSMoment momentWithDate:reference];
    expect([moment date]).notTo.beNil();
    expect([[moment date] isEqualToDate:reference]).to.beTruthy();
}

- (void)testCreateForDateMutation
{
    NSDate *reference = [NSDate date];
    NSMoment *moment  = [NSMoment momentWithDate:reference];

    expect([moment date] == reference).notTo.beTruthy();
}

- (void)testCreateFromNow
{
    NSMoment *moment = [NSMoment now];
    expect([moment date]).notTo.beNil();
}

- (void)testCreateFromStringWithoutFormat
{
    NSMoment *moment = [NSMoment momentWithDateAsString:@"Aug 9, 1995"];
    expect([moment date]).notTo.beNil();
    
    moment = [NSMoment momentWithDateAsString:@"Mon, 25 Dec 1995 13:30:00 GMT"];
    expect([moment date]).notTo.beNil();
    
    moment = [NSMoment momentWithDateAsString:@"I'm not a date"];
    expect([moment date]).to.beNil();
}

- (void)testCreateFromStringWithFormatDroppedAMPMBug
{
    expect([[NSMoment momentWithDateAsString:@"05/1/2012 12:25:00" format:@"MM/d/yyyy hh:mm:ss"] format:@"MM/dd/yyyy"]).to.equal(@"05/01/2012");
    expect([[NSMoment momentWithDateAsString:@"05/1/2012 12:25:00 am" format:@"MM/d/yyyy hh:mm:ss a"] format:@"MM/dd/yyyy"]).to.equal(@"05/01/2012");
    expect([[NSMoment momentWithDateAsString:@"05/1/2012 12:25:00 pm" format:@"MM/d/yyyy hh:mm:ss a"] format:@"MM/dd/yyyy"]).to.equal(@"05/01/2012");
}

- (void)testCreateFromEmptyStringWithFormats
{
    expect([[NSMoment momentWithDateAsString:@"" format:@"MM"] format:@"yyyy-MM-dd HH:mm:ss"]).to.equal(@"Invalid Date");
    expect([[NSMoment momentWithDateAsString:@" " format:@"MM"] format:@"yyyy-MM-dd HH:mm:ss"]).to.equal(@"Invalid Date");
    expect([[NSMoment momentWithDateAsString:@" " format:@"DD"] format:@"yyyy-MM-dd HH:mm:ss"]).to.equal(@"Invalid Date");
    
    expect([[NSMoment momentWithDateAsString:@"" format:@"MM"] isValid]).to.beFalsy();
    expect([[NSMoment momentWithDateAsString:@" " format:@"MM"] isValid]).to.beFalsy();
    expect([[NSMoment momentWithDateAsString:@" " format:@"DD"] isValid]).to.beFalsy();
}

@end
