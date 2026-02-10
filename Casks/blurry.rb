cask "blurry" do
  version "0.0.3"
  sha256 "1bf00b25e79192108a776e3f32c21368612b992a0621f864a3f0d3c0ee203e79"

  url "https://github.com/twttr/blurry/releases/download/v#{version}/Blurry-v#{version}.zip"
  name "Blurry"
  desc "Status bar utility for managing screen blur"
  homepage "https://github.com/twttr/blurry"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "Blurry.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{appdir}/Blurry.app"
  end

  zap trash: [
    "~/Library/Preferences/com.twttr.Blurry.plist",
    "~/Library/Saved Application State/com.twttr.Blurry.savedState",
  ]

  caveats <<~EOS
    Blurry is not signed or notarized.
    On first launch, if macOS blocks the app, open System Settings > Privacy & Security and click "Open Anyway".
  EOS
end
