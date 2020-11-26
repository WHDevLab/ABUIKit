//
//  ABUILabel.h
//  ABUIKit
//
//  
//  Copyright © 2020 ab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Constants for identifying link types we can detect
 */
typedef NS_ENUM(NSUInteger, ABLinkType)
{
    /**
     *  Usernames starting with "@" token
     */
    ABLinkTypeUserHandle,
    
    /**
     *  Hashtags starting with "#" token
     */
    ABLinkTypeHashtag,
    
    /**
     *  URLs, http etc
     */
    ABLinkTypeURL,
};

/**
 *  Flags for specifying combinations of link types as a bitmask
 */
typedef NS_OPTIONS(NSUInteger, ABLinkTypeOption)
{
    /**
     *  No links
     */
    ABLinkTypeOptionNone = 0,
    
    /**
     *  Specifies to include ABLinkTypeUserHandle links
     */
    ABLinkTypeOptionUserHandle = 1 << ABLinkTypeUserHandle,
    
    /**
     *  Specifies to include ABLinkTypeHashtag links
     */
    ABLinkTypeOptionHashtag = 1 << ABLinkTypeHashtag,
    
    /**
     *  Specifies to include ABLinkTypeURL links
     */
    ABLinkTypeOptionURL = 1 << ABLinkTypeURL,
    
    /**
     *  Convenience contstant to include all link types
     */
    ABLinkTypeOptionAll = NSUIntegerMax,
};


@class ABUILabel;

/**
 *  Type for block that is called when a link is tapped
 *
 *  @param label  The ABUILabel in which the tap took place
 *  @param string Content of the link that was tapped, includes @ or # tokens
 *  @param range  The range of the string within the label's text
 */
typedef void (^ABLinkTapHandler)(ABUILabel *label, NSString *string, NSRange range);

extern NSString * const ABUILabelLinkTypeKey;
extern NSString * const ABUILabelRangeKey;
extern NSString * const ABUILabelLinkKey;

/**
 * A UILabel subclass that highlights links, hashtags and usernames and enables response to user
 * interactions with those links.
 **/
IB_DESIGNABLE
@interface ABUILabel : UILabel <NSLayoutManagerDelegate>

/** ****************************************************************************************** **
 * @name Setting the link detector
 ** ****************************************************************************************** **/

/**
 * Enable/disable automatic detection of links, hashtags and usernames.
 */
@property (nonatomic, assign, getter = isAutomaticLinkDetectionEnabled) IBInspectable BOOL automaticLinkDetectionEnabled;

/**
 * Specifies the combination of link types to detect. Default value is ABLinkTypeAll.
 */
@property (nonatomic, assign) IBInspectable ABLinkTypeOption linkDetectionTypes;

/**
 * Set containing words to be ignored as links, hashtags or usernames.
 *
 * @discussion The comparison between the matches and the ignored words is case insensitive.
 */
@property (nullable, nonatomic, strong) NSSet *ignoredKeywords;

/** ****************************************************************************************** **
 * @name Format & Appearance
 ** ****************************************************************************************** **/

/**
 * The color used to highlight selected link background.
 *
 * @discussion The default value is (0.95, 0.95, 0.95, 1.0).
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *selectedLinkBackgroundColor;

/**
 * Flag sets if the sytem appearance for URLs should be used (underlined + blue color). Default value is NO.
 */
@property (nonatomic, assign) IBInspectable BOOL systemURLStyle;

/**
 * Get the current attributes for the given link type.
 *
 * @param linkType The link type to get the attributes.
 * @return A dictionary of text attributes.
 * @discussion Default attributes contain colored font using the tintColor color property.
 */
- (nullable NSDictionary*)attributesForLinkType:(ABLinkType)linkType;

/**
 * Set the text attributes for each link type.
 *
 * @param attributes The text attributes.
 * @param linkType The link type.
 * @discussion Default attributes contain colored font using the tintColor color property.
 */
- (void)setAttributes:(nullable NSDictionary*)attributes forLinkType:(ABLinkType)linkType;

/** ****************************************************************************************** **
 * @name Callbacks
 ** ****************************************************************************************** **/

/**
 * Callback block for ABLinkTypeUserHandle link tap.
 **/
@property (nullable, nonatomic, copy) ABLinkTapHandler userHandleLinkTapHandler;

/**
 * Callback block for ABLinkTypeHashtag link tap.
 */
@property (nullable, nonatomic, copy) ABLinkTapHandler hashtagLinkTapHandler;

/**
 * Callback block for ABLinkTypeURL link tap.
 */
@property (nullable, nonatomic, copy) ABLinkTapHandler urlLinkTapHandler;

/** ****************************************************************************************** **
 * @name Geometry
 ** ****************************************************************************************** **/

/**
 * Returns a dictionary of data about the link that it at the location. Returns nil if there is no link.
 *
 * A link dictionary contains the following keys:
 *
 * - **ABUILabelLinkTypeKey**, a TDLinkType that identifies the type of link.
 * - **ABUILabelRangeKey**, the range of the link within the label text.
 * - **ABUILabelLinkKey**, the link text. This could be an URL, handle or hashtag depending on the linkType value.
 *
 * @param point The point in the coordinates of the label view.
 * @return A dictionary containing the link.
 */
- (nullable NSDictionary*)linkAtPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
