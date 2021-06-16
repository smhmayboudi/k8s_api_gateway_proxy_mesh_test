use crate::api::{
    config::Config, controller::Controller, proto::server::api_server::ApiServer, service::Service,
};

#[derive(Clone, Debug)]
pub struct Server {
    inner: ApiServer<Controller>,
}

impl Server {
    pub fn into_inner(self) -> ApiServer<Controller> {
        self.inner
    }
}

impl Default for Server {
    fn default() -> Self {
        let config = Config::default();
        let service = Service::new(config.clone());
        let controller = Controller::new(config, service);

        Self {
            inner: ApiServer::new(controller),
        }
    }
}
