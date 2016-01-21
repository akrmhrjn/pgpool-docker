# pgpool-docker

This is the simple project that creates the image for the pg-pool.

You can pass the BACKEND_HOSTNAME as environment variable in comma separated string.

eg:
```
BACKEND_HOSTNAME=10.0.0.1,10.0.0.2
```

To run a docker image:

```
docker run -e "BACKEND_HOSTNAME=10.0.0.1,10.0.0.2" akrmhrjn/pgpool-docker:test
```
