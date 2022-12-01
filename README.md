# application

Experiment with Elm and Rust. See how far we can push performance and simplicity.
Goal is to be able to compose different web assembly nodes into one flow, and run
that flow as fast as possible.

## Ideas

- Use Sqlite with blobs for web assembly files (this is a read-heavy web application)
- Performance tuning everywhere. This is number one goal for this project
- Use Nix to easily deploy project everywhere

```
git clone https://github.com/knarkzel/application
cd application
nix develop
```

## Backend

```
cd backend
cargo watch -x run
```

## Frontend

```
cd frontend
elm-live src/Main.elm
```

