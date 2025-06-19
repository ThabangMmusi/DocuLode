#!/bin/bash

echo "Creating barrel files..."
dart scripts/create_barrels.dart

echo "Updating imports..."
dart scripts/update_imports.dart

echo "Checking for import errors..."
dart scripts/check_imports.dart

echo "Running dart analyze..."
dart analyze

echo "Import fixes completed!" 