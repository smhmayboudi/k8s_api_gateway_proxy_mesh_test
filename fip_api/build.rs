fn main() {
    tonic_build::configure()
        .build_client(false)
        // .proto_path("crate::api::proto")
        // .extern_path(".fip.api", "client")
        .compile(&["api_api.proto"], &["../fip_api/proto"])
        .unwrap();
}
