use std::net::SocketAddr;
use axum::{
    routing::get,
    Router, response::Html,
};

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    let app = Router::new()
        .route("/", get(index));

    let addr = SocketAddr::from(([127, 0, 0, 1], 3000));
    tracing::debug!("Listening on {addr}");
    
    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .expect("Failed to start axum");
}

async fn index() -> Html<&'static str> {
    Html("<h1>Hello, World!</h1>")
}
