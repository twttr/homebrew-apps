cask "mirroreu" do
  version "0.0.1"
  sha256 "4645e129cfd6bd0db582eeef62023831b6a16d75c43263d22f9448496419567e"

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
