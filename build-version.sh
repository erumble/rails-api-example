#!/bin/sh

echo "Copying ${CI_REPO_NAME} version ${CI_BRANCH} build artifacts to shared volume"

if [ -z $ARTIFACT_DIR ]; then
    echo "Please set the ARTIFACT_DIR env var then retry"
    exit 1
fi

if [ ! -d $ARTIFACT_DIR ]; then
    echo "Please mount a volume at ${ARTIFACT_DIR} then retry"
    exit 1
fi

# Clean artifact directory, then copy new artifacts
rm -f $ARTIFACT_DIR/version.json

# Convert CI_TIMESTAMP (unix timestamp) into a human readable date
build_date=$(date -d @${CI_TIMESTAMP})

# Create version file
cat << EOF > $ARTIFACT_DIR/version.json
{
  "repository": "${CI_REPO_NAME}",
  "version": "${CI_BRANCH}",
  "build_date": "${build_date}",
  "build_commit": "${CI_COMMIT_ID}"
}
EOF