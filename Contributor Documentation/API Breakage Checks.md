# API Breakage Checks

We have a CI jobs that checks for API breakages. Since swift-syntax releases increase the major version number, it is possible to make API-breaking changes – but we should avoid them whenever possible to avoid churn on clients when they update to a new swift-syntax version.

If your change contains an API breaking change, add the change to `api-breakages.txt`. All API breaking changes should be accompanied by an [RFC](RFC%20Process.md).
