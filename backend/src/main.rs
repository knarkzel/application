use std::net::SocketAddr;
use axum::{
    routing::post,
    Router, Form, Json,
};
use serde::{Deserialize, Serialize};

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    let app = Router::new()
        .route("/", post(run));

    let addr = SocketAddr::from(([127, 0, 0, 1], 3000));
    tracing::info!("Listening on {addr}");
    
    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .expect("Failed to start server");
}

#[derive(Deserialize)]
struct Node {
    input: i32,
}

#[derive(Serialize)]
struct Output {
    value: i32,
}

async fn run(Form(node): Form<Node>) -> Json<Output> {
    let output = Output { value: node.input * 2 };
    Json(output)
}
