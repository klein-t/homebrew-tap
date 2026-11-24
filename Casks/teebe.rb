cask "teebe" do
  version "0.9.0"
  sha256 "fa65ba7ac3d4e64ed53311a165266725ecedcaa454557bd073b21dca212d8e2a"

  url "https://dl.teebe.io/v#{version}/teebe-v#{version}.zip"
  name "teebe"
  desc "Git worktree manager"
  homepage "https://teebe.io/"

  livecheck do
    url "https://github.com/klein-t/teebe"
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
