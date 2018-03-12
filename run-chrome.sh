#!/bin/bash

google-chrome-stable \
  --disable-gpu \
  --headless \
  --hide-scrollbars \
  --remote-debugging-address=0.0.0.0 \
  --remote-debugging-port=9222
