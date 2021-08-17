conventional-commits-next-version-checking:
    stage: conventional-commits-next-version-checking
    image: rust
    before_script:
        - cargo install conventional_commits_next_version --version ^4
    script:
        # Get current version and latest tag.
        - CURRENT_VERSION=$(grep '^version = "[0-9][0-9]*.[0-9][0-9]*.[0-9][0-9]*"$' Cargo.toml | cut -d '"' -f 2)
        # Get latest tag.
        - LATEST_TAG=$(git describe --tags --abbrev=0)
        # Check latest tag is in semantic versioning.
        - echo "$LATEST_TAG" | grep "^[0-9][0-9]*.[0-9][0-9]*.[0-9][0-9]*$"
        # Check current vs expected.
        - /usr/local/cargo/bin/conventional_commits_next_version --batch-commits --from-reference "$LATEST_TAG" --from-version "$LATEST_TAG" --current-version "$CURRENT_VERSION"
    rules:
        - if: $CI_MERGE_REQUEST_ID


https://crates.io/crates/conventional_commits_next_version



[commit]
  algorithm = minimal
  renames = copies
  tool = code
