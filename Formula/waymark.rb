class Waymark < Formula
  desc "Local dev host: stable URLs, on-demand wakeups, local HTTPS"
  homepage "https://github.com/waymark-dev"
  url "https://github.com/waymark-dev/homebrew-tap/archive/refs/tags/v0.1.31.tar.gz"
  sha256 "631594d7d4740d48fb33b3a1731073bb382eb75f2938f75e3f8bdffbefaca27e"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/waymark-dev/homebrew-tap/releases/download/v0.1.31"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3b5619a8b9ac6edc4f064271fe753f29ebd1dfc538ab87e0f495bebaa579880f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d50500f1f23d34592031cf4f413c1246b54dc2fea17c99672f4e13bd109c973c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3e6588f4c06924f57c2cd78b294c1e82e94333f95cf6edf39ccc6b21fb07a264"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "50987068106c9b0d13b8164b42e35ee4f85d5a67d45e410d09625c483dc28f00"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "77abd50a2ebd9e50a3f85e8e0c83cd6ca046ac62e272338b05f5ebdc1b911348"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "c12c5cfba1977fc62b877698855ff012259c9f6e616802e413a3f2db51e80ba2"
    sha256 cellar: :any_skip_relocation, big_sur:        "6c640c56df92e3fe64f46a119292384dcfd6ccda1da05d1a5d99410fa77cd6cd"
    sha256 cellar: :any_skip_relocation, monterey:       "629fc1c075cce87123591eec6ae92d474cd65394dddfd48cb298c732f1e089f1"
    sha256 cellar: :any_skip_relocation, ventura:        "d56aecca250e56b16fa9406692a8e6f931a8f6e418c1962a29e948c036ba9b17"
    sha256 cellar: :any_skip_relocation, sonoma:         "d505c4eddecc6f4b32dcbbbbf7ea5f2b549ee80649072fb602618942ae87ff3c"
    sha256 cellar: :any_skip_relocation, sequoia:        "629fc1c075cce87123591eec6ae92d474cd65394dddfd48cb298c732f1e089f1"
    sha256 cellar: :any_skip_relocation, tahoe:          "1807fb7050658333b739a0e90b19cbc371208c8c2d21dc569add57f582066356"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/waymark-cli")
    system "cargo", "install", *std_cargo_args(path: "crates/waymark-daemon")
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
