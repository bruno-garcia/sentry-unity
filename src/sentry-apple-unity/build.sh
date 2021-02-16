# TODO: iphonesimulator ?
export sdk=iphoneos

xcodebuild clean build \
  -workspace sentry-cocoa/Sentry.xcworkspace \
  -scheme Sentry \
  -configuration Release \
  -sdk $sdk \
  -derivedDataPath derived-data \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  CLANG_ENABLE_CODE_COVERAGE=NO \
  MACH_O_TYPE=staticlib

export output=build/$sdk
mkdir -p $output
cp -r derived-data/Build/Products/Release-$sdk/Sentry.framework $output

mkdir -p ../../sentry-unity/Assets/Plugins/iOS/
cp build/iphoneos/Sentry.framework/Sentry ../../sentry-unity/Assets/Plugins/iOS/Sentry.a
cp -r build/iphoneos/Sentry.framework/Headers/*.h ../../sentry-unity/Assets/Plugins/iOS/