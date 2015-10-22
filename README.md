# testdroid-ssa-client-example

This repository has an example setup for use with the testdroid-ssa-client found at:
https://github.com/ujappelbe/testdroid-ssa-client

## Usage
### Clone this repository
```
git clone https://github.com/ujappelbe/testdroid-ssa-client-example.git
cd testdroid-ssa-client-example/
```

### Clone the repository containing example test application
```
git clone https://github.com/Applifier/unity-ads unity-ads
```

### Build the test application (requires android SDK and gradle)
```
(cd unity-ads/android/example ; gradle build)
```

### Clone the testdroid-ssa-client
```
git clone https://github.com/uJappelbe/testdroid-ssa-client
```

### Get your device group id (Place your testdroid API-key and project name in place of placeholders)
```
cd testdroid-ssa-client
./testdroid_cmdline.sh -u $TD_API_TOKEN -t "$TD_PROJECT" -l
# OR You can use username + password instead of API-Key by using the '-u' and '-p' switches
./testdroid_cmdline.sh -u $TD_USERNAME -p $TD_PASSWORD -t "$TD_PROJECT" -l
```

### Run test on server side appium (Place your testdroid API-key and project name in place of placeholders)
```
TD_BUILD="../unity-ads/android/example/build/outputs/apk/example-debug.apk"
./testdroid_cmdline.sh -u $TD_API_TOKEN -t "$TD_PROJECT" -a "$TD_BUILD" -r "My first SSA test" -z ../tests/ -d $TD_DEVICE_GROUP_ID
```
### Client should now start running test on testdroid cloud.


## To run test locally (on emulator or real device)
```
git clone https://github.com/ujappelbe/testdroid-ssa-client-example.git
cd testdroid-ssa-client-example/
```

### Clone the repository containing example test application
```
git clone https://github.com/Applifier/unity-ads unity-ads
```

### Build the test application (requires android SDK and gradle)
```
(cd unity-ads/android/example ; gradle build)
```

### Run the test
```
cd tests
./run-tests-android.sh
```
