class Waymark < Formula
  desc "Local dev host: stable URLs, on-demand wakeups, local HTTPS"
  homepage "https://github.com/waymark-dev"
  url "https://github.com/waymark-dev/homebrew-tap/archive/refs/tags/v0.1.32.tar.gz"
  sha256 "d2c02a150011d58a25b0303ab1d64040cc62bf548599b6754174ed5431e0a15d"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/waymark-dev/homebrew-tap/releases/download/v0.1.32"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "523c2b00a51289676ac48d7bd60281be7c80a38758b5731ac328608edca0b91c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a999e81eda1613db46b31cbd56484dccaa9497110333b57186934c04863a0661"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "139e02a06bf4301d33cae227f029e2fcf3e8954496217efe5fe2195693f063d7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "afc64ea385209a17f9390b0c9e3ed508ddac8403ee3f4cf24153a133599e3402"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ec613db47159d49f9095418795c0cd137e32433cf3e176f796c4483a10c25595"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "bec39727e0e39bae548eb88f0fb9bc33c9b017c7642b22c8b0dac5dd9f865aff"
    sha256 cellar: :any_skip_relocation, big_sur:        "02d35117fda176961dbed7a4c24b56f97d717bb386b005dec07cc8e05efbc675"
    sha256 cellar: :any_skip_relocation, monterey:       "7b60e1e4e93e2caa90cc3307527979788738a63338d0611c5ebf8b429be8b03b"
    sha256 cellar: :any_skip_relocation, ventura:        "1957a8a55b7eff5085bf6abe7c8261ffa8152cc0aa5d6222ff3cc13b17aed09f"
    sha256 cellar: :any_skip_relocation, sonoma:         "f09072a84e89bdff3924f6d7cccd7905cd6f58a4296c0d0491591688b9052bee"
    sha256 cellar: :any_skip_relocation, sequoia:        "1957a8a55b7eff5085bf6abe7c8261ffa8152cc0aa5d6222ff3cc13b17aed09f"
    sha256 cellar: :any_skip_relocation, tahoe:          "511c1de579c1e0773cfc3a176b22422e7a4f5f5bca682d8cbcd6c7b3266a3cde"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/waymark-cli")
    system "cargo", "install", *std_cargo_args(path: "crates/waymark-daemon")
  end

  def post_install
    label = "network.gyorffy.waymark.daemon"
    target = "gui/#{Process.uid}/#{label}"
    return unless quiet_system("launchctl", "print", target)

    return if quiet_system("launchctl", "kickstart", "-k", target)

    opoo "Waymark was upgraded, but the running daemon was not restarted."
    opoo "Run `launchctl kickstart -k #{target}` to use the new version now."
  end

  service do
    run [opt_bin/"waymarkd"]
    keep_alive true
    log_path var/"log/waymark/waymarkd.log"
    error_log_path var/"log/waymark/waymarkd.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/waymark --version")
    assert_match version.to_s, shell_output("#{bin}/waymarkd --version")
  end
end
