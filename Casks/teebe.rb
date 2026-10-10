cask "teebe" do
  version "0.8.1"
  sha256 "668ef876ac516b1889232c034fc320d3b2712f7342a6bf1000825c02836b5c40"

  url "https://github.com/klein-t/teebe/releases/download/v#{version}/teebe-v#{version}.zip"
  name "teebe"
  desc "Git worktree manager"
  homepage "https://teebe.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "teebe.app"

  # teebe is ad-hoc signed and not notarized yet. Remove the quarantine flag
  # from the installed app bundle only, so it opens without the Gatekeeper
  # prompt. Idempotent and never fails the install.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/teebe.app"],
        must_succeed: false,
        print_stderr: false
  end

  zap trash: [
    "~/Library/Application Support/teebe",
    "~/Library/Caches/dev.teebe.app",
    "~/Library/Preferences/dev.teebe.app.plist",
  ]

  caveats <<~EOS
    teebe is not notarized yet. This cask removes the quarantine flag from
    teebe.app so it opens without the Gatekeeper prompt.

    If macOS still blocks the first launch, open
    System Settings > Privacy & Security and click Open Anyway.
  EOS
end
