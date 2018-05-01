# chromium-headless-printtopdf
Basic setup for testing Chrome Headless printToPDF issues

#### https://bugs.chromium.org/p/chromium/issues/detail?id=819735 (incorrect-overflow)
#### https://bugs.chromium.org/p/chromium/issues/detail?id=774970 (image-clipped)
#### https://bugs.chromium.org/p/chromium/issues/detail?id=838497 (css-filter-downgrade)

### repo setup (requires nodejs 8+)
```sh
git clone https://github.com/soncodi/chromium-headless-printtopdf.git
cd chromium-headless-printtopdf

# setup node
npm install
```

### (a) run headless directly
```sh
./run-chrome.sh   # runs google-chrome-stable
                  # or
./run-chromium.sh # runs chromium-browser
```

### (b) run headless inside docker
```sh
# build and run docker comtainer
docker build -t headless .
./run-headless.sh
```

### generate PDF
```sh
# run chrome/chromium with debugging:
# perform either (a) or (b) above

# run node app
node app.js

# input and output files are in ./fixture folder
```

### change port number
The default debugging port number is 9222. It can be changed to e.g. 9223 if there is already a debugger listening on that port. It must be changed in [the node client app](app.js) **and** in the script running the renderer (e.g. [run-chromium.sh](run-chromium.sh)).
