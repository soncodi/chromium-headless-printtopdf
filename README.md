# chromium-headless-printtopdf
Basic setup for testing Chrome Headless printToPDF issues

#### https://bugs.chromium.org/p/chromium/issues/detail?id=819735
#### https://bugs.chromium.org/p/chromium/issues/detail?id=774970

### repo setup
```sh
git clone https://github.com/soncodi/chromium-headless-printtopdf.git
cd chromium-headless-printtopdf

# setup node
npm install

# build and run docker comtainer
docker build -t headless .
./run-headless.sh

# run node app
node app.js

# input and output files are in ./fixture folder

```
