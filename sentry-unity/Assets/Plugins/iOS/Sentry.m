#import "Sentry.h"

#if __cplusplus
extern "C" {
#endif
   
void sentry_init()
{
    [SentrySDK startWithConfigureOptions:^(SentryOptions *options) {
        options.dsn = @"https://94677106febe46b88b9b9ae5efd18a00@o447951.ingest.sentry.io/5439417";
        options.debug = @YES; // TODO: Get config from Unity
    }];

    [SentrySDK captureMessage:@"test"];
}

#if __cplusplus
}   // Extern C
#endif
