require "json"

class Tidesurf < Formula
  desc "Stateful Chromium tools with compact DOM text for browser agents"
  homepage "https://tidesurf.org"
  url "https://registry.npmjs.org/@tidesurf/core/-/core-0.6.2.tgz"
  sha256 "0c441840f4341f2c53c7cc9cf478cc561ac48e33df7cb206668931081e2c08f9"
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
      clipboard_write download
    ]
    assert_equal expected, result.fetch("data").map { |tool| tool.fetch("name") }
  end
end
