cask "mirroreu" do
  version "1.0"
  sha256 :no_check

  url "https://github.com/twttr/mirroreu/releases/download/v#{version}/Mirroreu-v#{version}.zip"
  name "Mirroreu"
  desc "Enables iPhone Mirroring in EU regions"
  homepage "https://github.com/twttr/mirroreu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "Mirroreu.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{appdir}/Mirroreu.app"
  end

  zap trash: [
    "~/Library/Preferences/com.twttr.Mirroreu.plist",
    "~/Library/Saved Application State/com.twttr.Mirroreu.savedState",
  ]

  caveats <<~EOS
    Mirroreu is not signed or notarized.
    On first launch, if macOS blocks the app, open System Settings > Privacy & Security and click "Open Anyway".
  EOS
end
