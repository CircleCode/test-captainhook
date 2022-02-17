#!/bin/bash

docker compose run --rm --no-deps app composer install -q

git restore --staged src
git restore src

cat << 'EOF' > ./src/test.php
<?php

$a =        "foo";
$b =        "bar";
EOF

git add ./src/test.php

cat << 'EOF' > ./src/test.php
<?php

$a =        "foo";
$c =        "baz";
EOF

echo "----------------------------------------"
echo "git status before commit"
echo

git status

echo "----------------------------------------"
echo "file content before commit"
echo

cat ./src/test.php

git commit -m 'test'

status="$?"

echo "----------------------------------------"
echo "git status after failed commit ($status)"
echo
git status

echo "----------------------------------------"
echo "file content after commit"
echo

cat ./src/test.php