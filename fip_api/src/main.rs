pub mod api;
pub mod config;
pub mod server;
pub mod trace;

use crate::{config::Config, server::Server, trace::Trace};
use anyhow::Result;

#[tokio::main]
async fn main() -> Result<()> {
    let config = Config::default();

    Trace::init(&config)?;

    Server::init(&config).await
}
