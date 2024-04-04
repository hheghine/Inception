#!/bin/sh

echo "[INFO] Adjusting permissions..."
chmod -R 755 /app/public

# Start server
echo "[INFO] Starting server..."
node server.js