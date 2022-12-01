use std::net::SocketAddr;
use axum::{
    routing::post,
    Router, Form, Json, http::Method,
};
use serde::{Deserialize, Serialize};
use tower_http::cors::{CorsLayer, Any};

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    let cors = CorsLayer::new()
        .allow_methods([Method::GET, Method::POST])
        .allow_origin(Any);

    let app = Router::new()
        .route("/", post(run))
        .layer(cors);

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
