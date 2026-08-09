require "json"

class Tidesurf < Formula
  desc "Stateful Chromium tools with compact DOM text for browser agents"
  homepage "https://tidesurf.org"
  url "https://registry.npmjs.org/@tidesurf/core/-/core-0.7.0.tgz"
  sha256 "bf9cb0a75777c52ac1def203f1a93736314f943e4ece4b9e278c88a5bbac1985"
  license "Apache-2.0"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tidesurf --version").strip

    result = JSON.parse(shell_output("#{bin}/tidesurf tools --json"))
    assert result.fetch("success")
    expected = %w[
      get_state navigate click type select scroll extract evaluate list_tabs
      new_tab switch_tab close_tab search screenshot upload clipboard_read
      clipboard_write download list_skills read_skill
    ]
    assert_equal expected, result.fetch("data").map { |tool| tool.fetch("name") }
  end
end
