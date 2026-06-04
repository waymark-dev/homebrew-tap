class Waymark < Formula
  desc "Local dev host: stable URLs, on-demand wakeups, local HTTPS"
  homepage "https://github.com/waymark-dev"
  url "https://github.com/waymark-dev/homebrew-tap/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "Apache-2.0"

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
