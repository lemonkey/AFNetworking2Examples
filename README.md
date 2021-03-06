AFNetworking2Examples
=====================

I recently went through a fairly large refactoring of iOS networking code to upgrade it from using AFNetworking 1.x to AFNetworking 2.1 as well as to take advantage of the latest networking updates for iOS 7.  Along the way I reviewed various resources and uncovered various gotchas and things to be mindful of.

In this repository I've created a simple iOS app that demonstrates various ways you can use the latest AFNetworking library and the newest Foundation networking libraries for iOS 7.  It can be a useful way to review various patterns that use AFHTTPRequestOperation and AFHTTPURLSessionManager.

While I show how you can write your own AFHTTPResponseSerializer sub-class, I didn't get into how you override the request creation process to take advantage of the results of custom parsing logic.

AFHTTPRequestOperation still uses NSURLConnection while AFHTTPURLSession uses NSURLSession, first available in iOS 7.

Note that this example project uses CocoaPods to import the latest AFNetworking library.

## Examples
- AFHTTPRequestOperation
- AFHTTPRequestOperationManager
- AFHTTPRequestOperationManager using a client category class
- AFHTTPURLSessionManager
- AFHTTPURLSessionManager using a client that uses delegate callbacks
- AFHTTPURLSessionManager using a client category class

## Resources

### From the [Source](http://github.com/afnetworking/afnetworking)
- [Official AFNetworking documentation](http://cocoadocs.org/docsets/AFNetworking/2.0.0/)
- [AFNetworking 2.0 Migration Guide](https://github.com/AFNetworking/AFNetworking/wiki/AFNetworking-2.0-Migration-Guide)
- [AFNetworking 2.0 - NSHipster](http://nshipster.com/afnetworking-2/)
- [From NSURLConnection to NSURLSession - iOS 7](http://www.objc.io/issue-5/from-nsurlconnection-to-nsurlsession.html)
- [AFNetworking on StackOverflow](http://stackoverflow.com/tags/afnetworking/info)

### Others
- [What's new in Foundation Networking - WWDC 2013](http://asciiwwdc.com/2013/sessions/705?q=nsurlsession)
- [AFNetworking 2.0 Tutorial](http://www.raywenderlich.com/59255/afnetworking-2-0-tutorial)
- [NSURLSession Tutorial](http://www.raywenderlich.com/51127/nsurlsession-tutorial)
- [Migrating from AFNetworking 1.x to AFNetworking 2](http://gavrix.wordpress.com/2013/10/16/migrating-from-afnetworking-1-x-to-afnetworking-2/)
- [Working with NSURLSession and AFNetworking 2.0](http://code.tutsplus.com/tutorials/working-with-nsurlsession-afnetworking-20--mobile-22651)
- [Working with AFNetworking 2](http://programmingthomas.com/blog/2013/9/17/working-with-afnetworking-2)
- [AFNetworking 2.0 Screencast](http://nsscreencast.com/episodes/91-afnetworking-2-0)

### Known Issues
- [AFHTTPSessionManager and NSOperation with dependencies](https://github.com/AFNetworking/AFNetworking/issues/1504)
- [NSURLSession and NSURLSessionDataTasks](https://github.com/AFNetworking/AFNetworking/issues/1838)
