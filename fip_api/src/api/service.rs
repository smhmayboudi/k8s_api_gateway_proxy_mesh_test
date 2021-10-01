use crate::api::{
    config::Config,
    proto::server::{ApiHelloWorldReq, ApiRes},
};
use fip_common::common_error::CommonError;

#[derive(Debug)]
pub struct Service {
    config: Config,
}

impl Service {
    pub fn new(config: Config) -> Self {
        Service { config }
    }
}

impl Service {
    #[tracing::instrument(fields(otel.kind = "client"))]
    pub async fn hello_world(&self, req: &ApiHelloWorldReq) -> Result<ApiRes, CommonError> {
        Ok(ApiRes { id: req.id.clone() })
    }
}
