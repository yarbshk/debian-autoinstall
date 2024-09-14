#!/bin/bash
set -e
COMPONENT_NAME=$1
if [[ -z "$COMPONENT_NAME" ]]; then
  echo "E: Component name is required"
  exit 1
fi
COMPONENT_PATH=./components/$COMPONENT_NAME.sh
cat <<EOF > $COMPONENT_PATH
#!/bin/bash
set -e
EOF
chmod +x $COMPONENT_PATH
echo "Component has been created on path: $COMPONENT_PATH"
