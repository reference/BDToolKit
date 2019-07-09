/**
 MIT License
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
#import <Foundation/Foundation.h>

@interface NSObject (NSCoding) <NSSecureCoding>

/**
 * Returns a dictionary containing the names and classes of all the properties of
 * the class that will be automatically saved, loaded and copied when the object
 * is archived using `NSKeyedArchiver/Unarchiver`. The values of the dictionary
 * represent the class used to encode each property (e.g. `NSString` for strings,
 * `NSNumber` for numeric values or booleans, `NSValue` for structs, etc).
 *
 * This dictionary is automatically generated by scanning the properties defined
 * in the class definition at runtime. Read-only and private properties will also
 * be coded as long as they have KVC-compliant ivar names (i.e. the ivar matches
 * the property name, or is the same but with a _ prefix). Any properties that
 * are not backed by an ivar, or whose ivar name does not match the property name
 * will not be encoded (this is a design feature, not a limitation - it makes it
 * easier to exclude properties from encoding)
 *
 * It is not normally necessary to override this method unless you wish to add
 * ivars for coding that do not have matching property definitions, or if you
 * wish to code virtual properties (properties or setter/getter method pairs that
 * are not backed by an ivar). If you wish to exclude certain properties from the
 * serialisation process, you can deliberately give them an non KVC-compliant
 * ivar name (see above).
 *
 * Note that this method only returns the properties defined on a particular
 * class and not any properties that are inherited from its superclasses. You
 * *do not* need to call `[super codableProperties]` if you override this method.
 */
+ (NSDictionary<NSString *, Class> *_Nullable)codableProperties;

/**
 * Populates the object's properties using the provided `NSCoder` object, based
 * on the `codableProperties` dictionary. This is called internally by the
 * `initWithCoder:` method, but may be useful if you wish to initialise an object
 * from a coded archive after it has already been created. You could even
 * initialise the object by merging the results of several different archives by
 * calling `setWithCoder:` more than once.
 */
- (void)setWithCoder:(NSCoder *_Nullable)aDecoder;

/**
 * Returns all the codable properties of the object, including those that are
 * inherited from superclasses. You should not override this method - if you
 * want to add additional properties, override the `+codableProperties` class
 * method instead.
 */
@property (nonatomic, readonly) NSDictionary<NSString *, Class> * _Nullable codableProperties;

/**
 * Returns a dictionary of the values of all the codable properties of the
 * object. It is equivalent to calling `dictionaryWithValuesForKeys:` with the
 * result of `object.codableProperties.allKeys` as the parameter.
 */
@property (nonatomic, readonly) NSDictionary<NSString *, id> * _Nullable dictionaryRepresentation;

/**
 * Attempts to load the file using the following sequence: 1) If the file is an
 * NSCoded archive, load the root object and return it; 2) If the file is an
 * ordinary Plist, load and return the root object; 3) Return the raw data as an
 * `NSData` object. If the de-serialised object is not a subclass of the class
 * being used to load it, an exception will be thrown (to avoid this, call the
 * method on `NSObject` instead of a specific subclass).
 */
+ (nullable instancetype)objectWithContentsOfFile:(NSString *_Nullable)path;

/**
 * Attempts to write the file to disk. This method is overridden by the
 * equivalent methods for `NSData`, `NSDictionary` and `NSArray`, which save the
 * file as a human-readable XML Plist rather than a binary NSCoded Plist archive,
 * but the `objectWithContentsOfFile:` method will correctly de-serialise these
 * again anyway. For any other object it will serialise the object using the
 * `NSCoding` protocol and write out the file as a NSCoded binary Plist archive.
 * Returns `YES` on success and `NO` on failure.
 */
- (BOOL)writeToFile:(NSString *_Nullable)filePath atomically:(BOOL)useAuxiliaryFile;

@end
