cask "spacemover" do
  version "0.0.1"
  sha256 :no_check

  url "https://github.com/twttr/SpaceMover/releases/download/v#{version}/SpaceMover-v#{version}.zip"
  name "SpaceMover"
  desc "Move macOS Spaces between displays with a click or hotkey"
  homepage "https://github.com/twttr/SpaceMover"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "SpaceMover.app"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{appdir}/SpaceMover.app"
  end

  zap trash: [
    "~/Library/Preferences/com.twttr.SpaceMover.plist",
    "~/Library/Saved Application State/com.twttr.SpaceMover.savedState",
  ]

  caveats <<~EOS
    SpaceMover is not signed or notarized.
    On first launch, if macOS blocks the app, open System Settings > Privacy & Security and click "Open Anyway".

    SpaceMover requires partial SIP disable for Mach injection into Dock.app:
      csrutil enable --without debug
  EOS
end
