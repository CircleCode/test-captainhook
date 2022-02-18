#!/bin/bash

docker compose run --rm --no-deps app composer install -q

git restore --staged src
git restore src

cat << 'EOF' > ./src/test.php
<?php

$a =        "foo"
$b =        "bar";
EOF

git add ./src/test.php

echo "----------------------------------------"
echo "manually running the pre-commit hook"
(cd .. && .git/hooks/pre-commit)

echo "----------------------------------------"
echo "commit"
git commit -m 'test'