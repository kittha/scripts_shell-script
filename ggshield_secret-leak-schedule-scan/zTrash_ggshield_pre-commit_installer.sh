#!/bin/bash


echo "install pre-commit-ggshield"
echo "please input GITGUARDIAN_API_KEY (scope=scan)"
  read GITGUARDIAN_API_KEY

echo "init installing"
pip install pre-commit

cat <<EOL > .pre-commit-config.yaml
repos:
  - repo: https://github.com/gitguardian/ggshield
    rev: v1.28.0
    hooks:
      - id: ggshield
        language_version: python3
        stages: [commit]
EOL

echo "install the hook"
pre-commit install

echo "$GITGUARDIAN_API_KEY" >> .env
echo ".env" >> .gitignore


git commit -m "init ggshield pre-commit"






# rm -- "$0"
