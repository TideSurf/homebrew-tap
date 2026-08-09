require "json"

class Tidesurf < Formula
  desc "Stateful Chromium tools with compact DOM text for browser agents"
  homepage "https://tidesurf.org"
  url "https://registry.npmjs.org/@tidesurf/core/-/core-0.6.3.tgz"
  sha256 "5f8e6b0cd72d76ed821a079ef7e1cde3b20636d3030fd3da3c901cb74357d13b"
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
