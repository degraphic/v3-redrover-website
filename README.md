# v3-redrover-website
## Running the API and the website together
To run both the website (this repo) and the API server together, you'll need to start one of them on a different port. E.g.:

```
v3-Rails-Application: rails server
v3-redrover-website: rails server -p 3001
```