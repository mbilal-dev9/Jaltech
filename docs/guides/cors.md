# How-to change CORS configuration

This guide shows you how to configure CORS in the application.

## What is CORS?

CORS (Cross-origin resource sharing) allows you to define who’s allowed to interact with our API.

## How it works?

It blocks all requests from a different origin than our API.

## What is origin?

Origin is the combination of:
- protocol
- domain
- port

## How CORS is handled in this application?

The application uses `rack-cors` gem which is configured in [cors.rb](https://github.com/monterail/jaltech-backend/blob/main/config/initializers/cors.rb) file.

## How to allow send request from a different origin than our API?

Origins are defined in [cors.rb](https://github.com/monterail/jaltech-backend/blob/main/config/initializers/cors.rb) file.

```
origins ENV.fetch("CORS_ORIGIN_WHITELIST") { "*" }
```

You need to define the `CORS_ORIGIN_WHITELIST` environment variable with proper `origin` (remember that origin contains: protocol, domain, port).

## How to configure CORS on the Heroku (staging)?

1. Go to [settings](https://dashboard.heroku.com/apps/jaltech-backend-staging/settings)
2. Click `Reveal Config Vars`
3. Define (or change) the `CORS_ORIGIN_WHITELIST` environment variable.
