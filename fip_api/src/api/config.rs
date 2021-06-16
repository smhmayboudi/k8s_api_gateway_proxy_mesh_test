use fip_common::common_const::API;
use serde::Deserialize;
use std::net::SocketAddr;

fn default_app_name() -> String {
    env!("CARGO_PKG_NAME").into()
}

fn default_app_version() -> String {
    env!("CARGO_PKG_VERSION").into()
}

fn default_endpoint() -> String {
    format!("http://{}", default_socket_address())
}

fn default_socket_address() -> SocketAddr {
    ([0, 0, 0, 0], 8080).into()
}

fn default_token() -> String {
    API.into()
}

#[derive(Clone, Debug, Deserialize)]
pub struct Config {
    #[serde(default = "default_app_name")]
    app_name: String,
    #[serde(default = "default_app_version")]
    app_version: String,
    #[serde(default = "default_endpoint")]
    endpoint: String,
    #[serde(default = "default_socket_address")]
    socket_address: SocketAddr,
    #[serde(default = "default_token")]
    token: String,
}

impl Config {
    pub fn app_name(&self) -> String {
        self.app_name.clone()
    }

    pub fn app_version(&self) -> String {
        self.app_version.clone()
    }

    pub fn endpoint(&self) -> String {
        self.endpoint.clone()
    }

    pub fn socket_address(&self) -> SocketAddr {
        self.socket_address
    }

    pub fn token(&self) -> String {
        self.token.clone()
    }
}

impl Default for Config {
    fn default() -> Self {
        let _ = dotenv::dotenv().ok();
        match envy::prefixed(format!("{}_", default_token())).from_env() {
            Err(error) => panic!("{:?}", error),
            Ok(config) => config,
        }
    }
}
